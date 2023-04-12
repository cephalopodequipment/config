#!/bin/bash
# SCRIPT FOR ENVIRONMENTS WHERE VAULT USES CONSUL AS `STORAGE_BACKEND`
set -ex
DATE=$(date '+%Y-%-m-%d-%A-%B-%s')
mkdir -p /home/hashistack/backups/nomad
mkdir -p /home/hashistack/backups/consul

nomad operator snapshot save -address={{ key "backup/hashistack/NOMAD_SERVER" }} /home/hashistack/backups/nomad/nomad-${DATE}.snapshot | grep "State file written"
if [ $? == 0 ]; then
   output="{\"nomad_backup\":\"success\"}"
   zabbix_sender -z {{ key "backup/hashistack/ZABBIX_SERVER" }} -p 10051 -s {{ key "backup/hashistack/ZABBIX_HOST_NAME" }} -k {{ key "backup/hashistack/ZABBIX_TRAPPER_KEY" }} -o "${output}" 
else
   output="{\"nomad_backup\":\"fail\"}"
   zabbix_sender -z {{ key "backup/hashistack/ZABBIX_SERVER" }} -p 10051 -s {{ key "backup/hashistack/ZABBIX_HOST_NAME" }} -k {{ key "backup/hashistack/ZABBIX_TRAPPER_KEY" }} -o "${output}"
fi


consul snapshot save -http-addr={{ key "backup/hashistack/CONSUL_SERVER" }} /home/hashistack/backups/consul/consul-${DATE}.snapshot | grep "Saved and verified snapshot"
if [ $? == 0 ]; then
   output="{\"consul_backup\":\"success\"}"
   zabbix_sender -z {{ key "backup/hashistack/ZABBIX_SERVER" }} -p 10051 -s {{ key "backup/hashistack/ZABBIX_HOST_NAME" }} -k {{ key "backup/hashistack/ZABBIX_TRAPPER_KEY" }} -o "${output}" 
else
   output="{\"consul_backup\":\"fail\"}"
   zabbix_sender -z {{ key "backup/hashistack/ZABBIX_SERVER" }} -p 10051 -s {{ key "backup/hashistack/ZABBIX_HOST_NAME" }} -k {{ key "backup/hashistack/ZABBIX_TRAPPER_KEY" }} -o "${output}"
fi


find /home/hashistack/backups/nomad -type f -mtime +30 -delete
find /home/hashistack/backups/consul -type f -mtime +30 -delete
