#!/bin/bash

set -euo pipefail

apt install -y xfsprogs lz4

mkfs -t xfs /dev/nvme0n1
echo "/dev/nvme0n1	/mnt/database	xfs	defaults	0	0" >> /etc/fstab
mkdir /mnt/database
mount /mnt/database
