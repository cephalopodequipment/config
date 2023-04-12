#!/bin/bash
set -ex
DATE=$(date '+%Y-%-m-%d-%A-%B-%s')
mkdir -p /home/hashistack/backups/nomad
mkdir -p /home/hashistack/backups/consul
mkdir -p /home/hashistack/backups/vault

nomad operator snapshot save -address={{ key "backup/hashistack/NOMAD_SERVER" }} /home/hashistack/backups/nomad/nomad-${DATE}.snapshot | grep "State file written"
if [ $? == 0 ]; then
   output="{\"task\":\"nomad_backup\",\"status\":\"success\"}"
   zabbix_sender -z {{ key "backup/hashistack/ZABBIX_SERVER" }} -p 10051 -s {{ key "backup/hashistack/ZABBIX_HOST_NAME" }} -k {{ key "backup/hashistack/ZABBIX_TRAPPER_KEY" }} -o "${output}" 
else
     output="{\"task\":\"nomad_backup\",\"status\":\"failed\"}"
   zabbix_sender -z {{ key "backup/hashistack/ZABBIX_SERVER" }} -p 10051 -s {{ key "backup/hashistack/ZABBIX_HOST_NAME" }} -k {{ key "backup/hashistack/ZABBIX_TRAPPER_KEY" }} -o "${output}"
fi


consul snapshot save -http-addr={{ key "backup/hashistack/CONSUL_SERVER" }} /home/hashistack/backups/consul/consul-${DATE}.snapshot | grep "Saved and verified snapshot"
if [ $? == 0 ]; then
   output="{\"task\":\"consul_backup\",\"status\":\"success\"}"
   zabbix_sender -z {{ key "backup/hashistack/ZABBIX_SERVER" }} -p 10051 -s {{ key "backup/hashistack/ZABBIX_HOST_NAME" }} -k {{ key "backup/hashistack/ZABBIX_TRAPPER_KEY" }} -o "${output}" 
else
     output="{\"task\":\"consul_backup\",\"status\":\"failed\"}"
   zabbix_sender -z {{ key "backup/hashistack/ZABBIX_SERVER" }} -p 10051 -s {{ key "backup/hashistack/ZABBIX_HOST_NAME" }} -k {{ key "backup/hashistack/ZABBIX_TRAPPER_KEY" }} -o "${output}"
fi

VAULT_LEADER=$(vault operator raft list-peers --format=json -address={{ key "backup/hashistack/VAULT_SERVER" }} | jq --raw-output '.data.config.servers[] | select(.leader==true) | .address' | awk -F":" '{print $1}')
vault operator raft snapshot save -tls-skip-verify -address="https://${VAULT_LEADER}:8200" /home/hashistack/backups/vault/vault-${DATE}.snapshot
FILE="/home/hashistack/backups/vault/vault-${DATE}.snapshot"
if test -f "$FILE"; then
   output="{\"task\":\"vault_backup\",\"status\":\"success\"}"
   zabbix_sender -z {{ key "backup/hashistack/ZABBIX_SERVER" }} -p 10051 -s {{ key "backup/hashistack/ZABBIX_HOST_NAME" }} -k {{ key "backup/hashistack/ZABBIX_TRAPPER_KEY" }} -o "${output}" 
else
     output="{\"task\":\"vault_backup\",\"status\":\"failed\"}"
   zabbix_sender -z {{ key "backup/hashistack/ZABBIX_SERVER" }} -p 10051 -s {{ key "backup/hashistack/ZABBIX_HOST_NAME" }} -k {{ key "backup/hashistack/ZABBIX_TRAPPER_KEY" }} -o "${output}"
fi

find /home/hashistack/backups/nomad -type f -mtime +30 -delete
find /home/hashistack/backups/consul -type f -mtime +30 -delete
find /home/hashistack/backups/vault -type f -mtime +30 -delete


