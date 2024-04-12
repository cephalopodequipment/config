# Global application settings
[global]
json_log_fmt = true
batch_mode = {{ envOrDefault "BATCH_MODE" "true" }}
collect_gas = {{ envOrDefault "COLLECT_GAS" "false" }}
collect_tx_fees = {{ envOrDefault "COLLECT_TX_FEES" "false" }}

{{- with $chains := env "CHAINS" | split "," -}}
    {{ range $i := $chains }}
[chains.{{ $i }}]
        {{- range service "chainpulse0.network-node" -}}
            {{- if .Tags | contains $i }}
url = "http://{{ .Address }}:{{ index .ServiceMeta "PortRpc" }}"
            {{- end -}}
        {{ end }}
poll_interval = "{{ envOrDefault "POLL_INTERVAL" "500ms" }}"

backfill_from = {{ envOrDefault "BACKFILL_FROM" "0" }}

hrp           = "{{ $i | regexReplaceAll "(.*?)-[0-9]" "$1" }}"
    {{ end }}
{{- end }}

[database]
# URL for connecting to the Postgres database instance
# It should include the database username, password (if required), host,
# port, and the name of the database instance
{{ with secret "static_secrets/insights_db" }}

url = "postgres://insights:{{ .Data.data.password }}@{{ key "insights/rds_url" }}:5432"

{{- end }}

# Whether SSL mode should be enabled or not when connecting to the database.
ssl_mode = false

[metrics]
enabled = {{ envOrDefault "ENABLE_METRICS" "false" }}
{{- range service "zabbix-server" }}
#IP address of the zabbix server
zabbix_server_address = "{{ .Address }}"
{{ end }}
