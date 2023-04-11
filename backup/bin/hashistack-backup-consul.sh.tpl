#!/bin/bash
DATE=$(date '+%Y-%-m-%d-%A-%B-%s')
mkdir -p /home/hashistack/backups/nomad
mkdir -p /home/hashistack/backups/consul
mkdir -p /home/hashistack/backups/log

nomad operator snapshot save -address={{ key "backup/hashistack/NOMAD_SERVER" }} /home/hashistack/backups/nomad/nomad-${DATE}.snapshot > /home/hashistack/backups/log/backup-${DATE}.log

consul snapshot save -http-addr={{ key "backup/hashistack/CONSUL_SERVER" }} /home/hashistack/backups/consul/consul-${DATE}.snapshot >> /home/hashistack/backups/log/backup-${DATE}.log

find /home/hashistack/backups/log -type f -mtime +30 -delete
find /home/hashistack/backups/nomad -type f -mtime +30 -delete
find /home/hashistack/backups/consul -type f -mtime +30 -delete
