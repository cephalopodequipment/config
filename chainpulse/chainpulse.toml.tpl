[global]
json_log_fmt = true

{{- with $chains := env "CHAINS" | split "," -}}
    {{ range $i := $chains }}
[chains.{{ $i }}]
        {{- range service "sentry0.network-node" -}}
            {{- if .Tags | contains $i }}
url = "http://{{ .Address }}:{{ index .ServiceMeta "PortRpc" }}"
            {{- end -}}
        {{ end }}
comet_version = "{{ envOrDefault "COMET_VERSION" "0.34" }}"
poll_interval = "{{ envOrDefault "POLL_INTERVAL" "500ms" }}"
backfill_from = {{ envOrDefault "BACKFILL_FROM" "0" }}
    {{ end }}
{{- end }}
[database]
path = "{{ env "DB_PATH" }}"

[metrics]
enabled = false
port = 3332
