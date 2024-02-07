{{- range $chain_id, $pairs := tree "stakooler/" | explode }}
{{- range service "sentry0.network-node" }}
{{- if eq .ServiceMeta.ChainId $chain_id -}}
[[chains]]
id = "{{ $chain_id }}"
lcd = "http://{{ .Address }}:{{ index .ServiceMeta "PortRest" }}"

{{- range $key, $pairs := tree ($chain_id | printf "stakooler/%s") | explode -}}
{{ if eq $key "accounts" }}
{{ range $account, $pairs := tree ($chain_id | printf "stakooler/%s/accounts") | explode }}
  [[accounts]]
  name = "{{ $account }}"
  address = {{ $pairs }}
  chain = "{{ $chain_id }}"
{{ end }}
{{- else if eq $key "valoper" }}
  [[validators]]
  valoper = {{ $pairs }}
  chain = "{{ $chain_id }}"

{{ end }}{{ end }}{{ end }}{{ end }}{{ end -}}

[zabbix]
{{- range service "zabbix-server" }}
server = "{{ .Address }}"
port = {{ .ServiceMeta.ServerPort }}
host = "zabbix.cec"
{{ end }}
