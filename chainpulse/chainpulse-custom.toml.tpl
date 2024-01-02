[global]
json_log_fmt            = true
batch_mode              = true
zabbix_monitoring       = true
zabbix_server_address   = "10.10.42.40"

[chains.{{ env "CHAIN" }}]
url = "http://{{ env "IP" }}:{{ env "RPC_PORT" }}"
comet_version = "{{ envOrDefault "COMET_VERSION" "0.34" }}"
poll_interval = "{{ envOrDefault "POLL_INTERVAL" "500ms" }}"
backfill_from = {{ envOrDefault "BACKFILL_FROM" "0" }}
[database]
path = "{{ env "DB_PATH" }}"

[metrics]
enabled = false
port = 3332
