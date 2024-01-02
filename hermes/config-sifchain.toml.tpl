# Currently used for Hermes v1.7.1 or greater
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
clear_interval = {{ keyOrDefault (printf "hermes/relayers/%s/clear_interval" (env "JOB_NAME")) "89" }}
clear_on_start = {{ keyOrDefault (printf "hermes/relayers/%s/clear_on_start" (env "JOB_NAME")) "true" }}
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
latency_submitted = {{ keyOrDefault (printf "hermes/relayers/%s/latency_submitted" (env "JOB_NAME")) "{ start = 1000, end = 100000, buckets = 9 }" }}
latency_confirmed = {{ keyOrDefault (printf "hermes/relayers/%s/latency_confirmed" (env "JOB_NAME")) "{ start = 200, end = 20000, buckets = 9 }" }}

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
clear_interval = {{or .clear_interval 123 }}
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

[[ chains ]]
id = 'cosmoshub-4'
rpc_addr = '{{ env "COSMOS_RPC" }}'
grpc_addr = '{{ env "COSMOS_GRPC" }}'
event_source = { mode = 'push', url = '{{ env "COSMOS_WS" }}', batch_delay = '100ms' }
rpc_timeout = '8s'
trusted_node = false
account_prefix = 'cosmos'
key_name = '{{ env "COSMOS_AW_KEY" }}'
address_type = { derivation = 'cosmos' }
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Informal 🐙'
gas_price = {{ env "COSMOS_GAS_PRICE" }}
max_gas = {{ env "COSMOS_MAX_GAS" }}
ccv_consumer_chain = false
max_msg_num = 15
gas_multiplier = 1.2
max_tx_size = 180000
clock_drift = '120s'
trusting_period = '14days'
trust_threshold = { numerator = '2', denominator = '3' }
clear_interval = {{ env "COSMOS_CLEAR_INTERVAL" }}
packet_filter = { policy = 'allow', list = [['transfer', 'channel-192']] }
