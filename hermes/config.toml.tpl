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

[telemetry.buckets]
latency_submitted = { start = 500, end = 500000, buckets = 10 }
latency_confirmed = { start = 1000, end = 100000, buckets = 10 }

{{ range $chain_id, $job_config := (key (printf "hermes/relayers/%s/chain_config" (env "JOB_NAME")) | parseJSON) -}}
{{ with tree (printf "hermes/networks/%s" $chain_id) | explode }}
[[ chains ]]
id = '{{ $chain_id }}'
rpc_addr = 'http://{{ range service (printf "%s.network-node" $chain_id) }}{{ if .Tags | contains $job_config.node_service }}{{ .Address }}:{{ index .ServiceMeta "PortRpc" }}{{end}}{{end}}'
grpc_addr = 'http://{{ range service (printf "%s.network-node" $chain_id) }}{{ if .Tags | contains $job_config.node_service }}{{ .Address }}:{{ index .ServiceMeta "PortGrpc" }}{{end}}{{end}}'
event_source = { mode = 'push', url = 'ws://{{ range service (printf "%s.network-node" $chain_id) }}{{ if .Tags | contains $job_config.node_service }}{{ .Address }}:{{ index .ServiceMeta "PortRpc" }}{{end}}{{end}}/websocket', batch_delay = {{or .batch_delay "'500ms'"}} }
rpc_timeout = '8s'
trusted_node = {{or .trusted_node "false"}}
account_prefix = '{{ .account_prefix }}'
key_name = '{{ $job_config.key_name }}'
address_type = {{ .address_type }}
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Informal 🐙'
gas_price = {{ .gas_price }}
default_gas = {{or .default_gas "200000"}}
max_gas = {{ .max_gas }}
ccv_consumer_chain = {{or .ccv_consumer_chain "false"}}
max_msg_num = {{ .max_msg_num }}
gas_multiplier = {{ .gas_multiplier }}
max_tx_size = {{ .max_tx_size }}
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
