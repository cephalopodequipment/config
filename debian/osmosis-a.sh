#!/bin/bash

set -euo pipefail

log() {
  logger "$*"
  echo "$*"
}

log "Running custom bootstrap script for $(hostname)"

echo "deb http://deb.debian.org/debian buster-backports contrib non-free" > /etc/apt/sources.list.d/zfs.list
apt-get update
apt-get install -y linux-headers-4.19.0-20-cloud-amd64 lz4
apt-get install -y -t buster-backports zfsutils-linux

ZFS="new"
zpool create alpha nvme0n1 || ZFS="tainted"
if [ "$ZFS" == "tainted" ]; then
  log "ZFS pool already exists or other error."
else
  log "ZFS pool created."
fi

log "Finished custom bootstrap script for $(hostname)"
