#!/bin/bash
# CloudInit custom bootstrap.sh script
# Update this script to update the cloudinit execution for new AWS instances.
# It will not trigger a rebuild of existing instances.

set -euo pipefail

log() {
  logger "$*"
  echo "$*"
}

__HOSTNAME="$(hostname)"
__IP_ADDRESS="$(hostname -I | tr -d ' ')" # this has to run before docker is installed.

log "Starting remote bootstrap script on hostname ${__HOSTNAME} at IP ${__IP_ADDRESS}"
apt-get install -y sudo vim curl gpg jq

log "Installing syslog forwarder"
cat > /etc/rsyslog.d/remote.conf << EOF
# An on-disk queue is created for this action. If the remote host is
# down, messages are spooled to disk and sent when it is up again.
\$ActionQueueFileName sysmonRule1 # unique name prefix for spool files
\$ActionQueueMaxDiskSpace 5g   # 5gb space limit (use as much as possible)
\$ActionQueueSaveOnShutdown on # save messages to disk on shutdown
\$ActionQueueType LinkedList   # run asynchronously
\$ActionResumeRetryCount -1    # infinite retries if host is down
*.* @@10.10.20.102:1470
EOF
systemctl restart rsyslog

log "Installing Docker, Consul and Nomad clients"
source /etc/os-release # Get VERSION_CODENAME env.var which is "buster" at time of writing
# Apt Docker
wget -qO- https://download.docker.com/linux/debian/gpg | apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/debian ${VERSION_CODENAME} stable" > /etc/apt/sources.list.d/download_docker_com_linux_debian.list
# Apt Hashistack
wget -qO- https://apt.releases.hashicorp.com/gpg | apt-key add -
echo "deb [arch=amd64] https://apt.releases.hashicorp.com ${VERSION_CODENAME} main" > /etc/apt/sources.list.d/apt_releases_hashicorp_com.list
# Install
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io nomad consul
# CNI
mkdir -p /opt/cni/bin
#chmod 0775 /opt/cni/bin # We are testing if this is necessary.
wget -qO- https://github.com/containernetworking/plugins/releases/download/v1.0.0/cni-plugins-linux-amd64-v1.0.0.tgz | tar -xz -C /opt/cni/bin -f -
usermod -a -G docker admin

log "Configuring Consul"
cat > /etc/consul.d/client.hcl << EOF
node_name = "$__HOSTNAME"
datacenter = "aws-cac"
retry_join = ["10.10.41.104", "10.10.41.204", "10.10.20.102"]
client_addr = "$__IP_ADDRESS"
advertise_addr = "$__IP_ADDRESS"
connect {
  enabled = true
}
ports {
  grpc = 8502
}
limits {
  http_max_conns_per_client = 500
}
#encrypt = "<replace with encryption key>"
EOF
# TODO: the encryption key for consul is not set
# systemctl enable consul
# systemctl start consul

log "Configuring Nomad"
cat > /etc/nomad.d/nomad.hcl << EOF
name = "$__HOSTNAME"
datacenter = "aws-cac"
data_dir = "/opt/nomad/data"
client {
  enabled = true
  servers = [ "10.10.41.103", "10.10.41.203", "10.10.20.102" ]
}

consul {
  address = "${__IP_ADDRESS}:8500"
}
telemetry {
  publish_allocation_metrics = true
  prometheus_metrics = true
}
plugin "docker" {
  config {
    volumes {
      enabled = true
    }

    allow_privileged = true
  }
}
EOF
systemctl enable nomad
systemctl start nomad

log "Install Zabbix Agent"
wget -q https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/zabbix-release_6.0-1+${ID}${VERSION_ID}_all.deb

apt-get install -y ./zabbix-release_6.0-1+${ID}${VERSION_ID}_all.deb
apt-get update
apt-get install -y zabbix-agent2
cat > /etc/zabbix/zabbix_agent2.d/cec.conf << EOF
Server=10.10.41.102
ServerActive=10.10.41.102
Hostname=${__HOSTNAME}.cec
EOF
systemctl enable zabbix-agent2
systemctl restart zabbix-agent2

log "Install ZFS"
source /etc/os-release
KERNEL_RELEASE="$(uname -r)"
echo "deb http://deb.debian.org/debian ${VERSION_CODENAME}-backports contrib non-free" > /etc/apt/sources.list.d/zfs.list
apt-get update
apt-get install -y lz4 "linux-headers-${KERNEL_RELEASE}"
DEBIAN_FRONTEND=noninteractive apt-get install -y -t "${VERSION_CODENAME}-backports" zfs-dkms --no-install-recommends
modprobe zfs
apt-get install -y -t "${VERSION_CODENAME}-backports" zfsutils-linux

if [ -b /dev/nvme0n1 ]; then
  ZPOOL="new"
  zpool create alpha nvme0n1 || ZPOOL="tainted"
  if [ "$ZPOOL" == "tainted" ]; then
    log "ZFS pool alpha already exists or other error."
  else
    log "ZFS pool alpha created."
  fi

  ZFS="new"
  zfs create alpha/docker || ZFS="tainted"
  if [ "$ZFS" == "tainted" ]; then
    log "ZFS dataset alpha/docker already exists or other error."
  else
    log "ZFS dataset alpha/docker created."
  fi

  zfs set compression=lz4 alpha/docker
  zfs set mountpoint=/var/lib/docker/volumes alpha/docker
fi

log "Searching for per-server bootstrap script"
wget "https://raw.githubusercontent.com/cephalopodequipment/config/main/debian/${__HOSTNAME}.sh" || log "No custom file for this server"
if [ -f "${__HOSTNAME}.sh" ]; then
  log "Custom bootstrap file found."
  chmod 755 "${__HOSTNAME}.sh"
  source "${__HOSTNAME}.sh"
fi

log "Finished remote bootstrap script"
