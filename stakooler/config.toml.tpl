{{- range $chain, $pairs := tree "stakooler/" | explode -}}
  {{- range $key, $pairs := tree ($chain | printf "stakooler/%s") | explode -}}

    {{- if eq $key "lcd" -}}

    [[chains]]
    id = "{{ $chain }}"
    lcd = {{ $pairs }}

    {{- else if eq $key "valoper" -}}

    [[validators]]
    valoper = {{ $pairs }}
    chain = {{ $chain }}

    {{- else if eq $key "accounts" -}}
      {{- range $account, $pairs := tree ($chain | printf "stakooler/%s/accounts") | explode -}}

      [[accounts]]
      name = "{{ $account }}"
      address = {{ $pairs }}
      chain = {{ $chain }}

      {{ end }}
    {{ end }}
  {{ end }}
{{ end }}

[zabbix]
server = {{ key "stakooler/zabbix/server" }}
port = {{ key "stakooler/zabbix/port" }}
host = {{ key "stakooler/zabbix/host" }}