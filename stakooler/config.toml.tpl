{{- range $chain_id, $pairs := tree "stakooler/" | explode }}
[[chains]]
id = "{{ $chain_id }}"
{{ range $index, $value := service (printf "%s.cosmos-sdk-rest" $chain_id) -}}
{{ if eq $index 0 -}}
lcd = "http://{{ .Address }}:{{ .Port }}"
{{- end }}{{ end }}

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
{{ end }}{{ end }}{{ end -}}

[zabbix]
{{- range service "zabbix-server" }}
server = "{{ .Address }}"
port = {{ .ServiceMeta.ServerPort }}
host = "zabbix.cec"
{{ end }}
