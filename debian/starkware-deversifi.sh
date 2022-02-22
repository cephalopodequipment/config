#!/bin/bash

set -euo pipefail

log() {
  logger "$*"
  echo "$*"
}

log "Running custom bootstrap script for $(hostname)"

apt-get install -y xfsprogs lz4

XFS="new"
mkfs -t xfs /dev/nvme0n1 || XFS="tainted"
if [ "$XFS" == "tainted" ]; then
  log "XFS file system already exists or error formatting. Skipping database setup..."
else
  log "XFS file system formatted. Setting up automount..."
  echo "/dev/nvme0n1	/mnt/database	xfs	defaults	0	0" >> /etc/fstab
  mkdir /mnt/database
  mount /mnt/database
fi

log "Finished custom bootstrap script for $(hostname)"
