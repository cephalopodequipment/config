[global]
log_level = '{{ keyOrDefault (printf "hermes/relayers/%s/log_level" (env "JOB_NAME")) "info" }}'

[mode]
[mode.clients]
enabled = true
refresh = true
misbehaviour = false

[mode.connections]
enabled = false

[mode.channels]
enabled = false

[mode.packets]
enabled = true
clear_interval = 89
clear_on_start = true
tx_confirmation = true

[rest]
enabled = true
host = '0.0.0.0'
port = 3000

[telemetry]
enabled = true
host = '0.0.0.0'
port = 3001
{{ range $chain_id, $job_config := (key (printf "hermes/relayers/%s/chain_config" (env "JOB_NAME")) | parseJSON) -}}
{{ with tree (printf "hermes/networks/%s" $chain_id) | explode }}
[[ chains ]]
id = '{{ $chain_id }}'
rpc_addr = 'http://{{ range service $job_config.node_service }}{{ .Address }}:{{ index .ServiceMeta "PortRpc" }}{{end}}'
grpc_addr = 'http://{{ range service $job_config.node_service }}{{ .Address }}:{{ index .ServiceMeta "PortGrpc" }}{{end}}'
websocket_addr = 'ws://{{ range service $job_config.node_service }}{{ .Address }}:{{ index .ServiceMeta "PortRpc" }}{{end}}/websocket'
rpc_timeout = '8s'
account_prefix = '{{ .account_prefix }}'
key_name = '{{ $job_config.key_name }}'
address_type = {{ .address_type }}
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Informal 🐙'
gas_price = {{ .gas_price }}
max_gas = {{ .max_gas }}
max_msg_num = {{ .max_msg_num }}
gas_multiplier = {{ .gas_multiplier }}
max_tx_size = {{ .max_tx_size }}
batch_delay = "100ms"
clock_drift = '{{ .clock_drift }}'
trusting_period = '{{ .trusting_period }}'
trust_threshold = {{ .trust_threshold }}
packet_filter = { policy = 'allow', list = [
{{- $first := true -}}
{{- range $job_config.channels -}}
  {{- if $first -}}
      {{- $first = false -}}
  {{- else -}}
      ,
  {{- end -}}
  {{ . }}
{{- end -}}] }
{{ end }}{{ end }}
