{{- with $chains := env "CHAINS" | split "," -}}
    {{ range $i := $chains }}
[chains.{{ $i }}]
        {{- range service "sentry0.network-node" -}}
            {{- if .Tags | contains $i }}
url = "http://{{ .Address }}:{{ index .ServiceMeta "PortRpc" }}"
            {{- end -}}
        {{ end }}
comet_version = "{{ envOrDefault "COMET_VERSION" "0.34" }}"
    {{ end }}
{{- end }}
[database]
path = "/home/chainpulse/database/data.db"

[metrics]
enabled = false
port = 3332
