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

ZPOOL="new"
zpool create alpha nvme0n1 || ZPOOL="tainted"
if [ "$ZPOOL" == "tainted" ]; then
  log "ZFS pool alpha already exists or other error."
else
  log "ZFS pool alpha created."
fi

ZFS="new"
zfs create alpha/primary || ZFS="tainted"
if [ "$ZFS" == "tainted" ]; then
  log "ZFS dataset alpha/primry already exists or other error."
else
  log "ZFS dataset alpha/primary created."
fi


log "Finished custom bootstrap script for $(hostname)"
