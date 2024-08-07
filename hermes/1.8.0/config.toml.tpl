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
  {{ $chain_config := tree (printf "hermes/networks/%s" $chain_id) | explode -}}
    {{ range service (printf "%s.network-node" $chain_id) -}}
      {{ if .Tags | contains $job_config.node_service -}}
        {{ if eq $chain_id "penumbra-1" -}}

[[chains]]
id = '{{ $chain_id }}'
type = 'Penumbra'
stub_key_name = 'fake'
rpc_addr = 'http://{{ .Address }}:{{ index .ServiceMeta "PortRpc" }}'
grpc_addr = 'http://{{ .Address }}:{{ index .ServiceMeta "PortGrpc" }}'
view_service_storage_dir = "/home/hermes/view_storage"
event_source = { mode = 'pull', interval = '1s' }
rpc_timeout = '{{ or $chain_config.rpc_timeout 15s }}'
clock_drift = '5s'
client_refresh_rate = '{{ $chain_config.client_refresh_rate }}'
trust_threshold = {{ $chain_config.trust_threshold }}
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
{{if $chain_config.excluded_sequences}}excluded_sequences = {{or $chain_config.excluded_sequences "[]"}}{{end}}
{{ with secret "hermes/penumbra-1" }}
kms_config = { spend_key = "{{ .Data.data.rw1 }}" }
{{ end }}
        {{ else }}
[[ chains ]]
id = '{{ $chain_id }}'
rpc_addr = 'http://{{ .Address }}:{{ index .ServiceMeta "PortRpc" }}'
grpc_addr = 'http://{{ .Address }}:{{ index .ServiceMeta "PortGrpc" }}'
event_source = { mode = 'push', url = 'ws://{{ .Address }}:{{ index .ServiceMeta "PortRpc" }}/websocket', batch_delay = {{ or $chain_config.batch_delay "'500ms'"}} }
rpc_timeout = '8s'
type = "CosmosSdk"
{{- if eq $chain_id "celestia" }}
compat_mode = '{{ $chain_config.compat_mode }}'
{{- end }}
trusted_node = {{or $chain_config.trusted_node "false"}}
account_prefix = '{{ $chain_config.account_prefix }}'
key_name = '{{ $job_config.key_name }}'
address_type = {{ $chain_config.address_type }}
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Informal 🐙'
gas_price = {{ $chain_config.gas_price }}
default_gas = {{or $chain_config.default_gas "200000"}}
max_gas = {{ $chain_config.max_gas }}
dynamic_gas_price = { enabled = {{ or $chain_config.enable_dynamic_gas "false" }}, multiplier = {{ or $chain_config.dynamic_gas_multiplier 1 }}, max = {{ or $chain_config.dynamic_max_gas_price 0 }} }
ccv_consumer_chain = {{or $chain_config.ccv_consumer_chain "false"}}
max_msg_num = {{ $chain_config.max_msg_num }}
gas_multiplier = {{ $chain_config.gas_multiplier }}
max_tx_size = {{ $chain_config.max_tx_size }}
clock_drift = '{{ $chain_config.clock_drift }}'
trusting_period = '{{ $chain_config.trusting_period }}'
trust_threshold = {{ $chain_config.trust_threshold }}
    {{- if $chain_config.clear_interval }}
clear_interval = {{ or $chain_config.clear_interval 123 }}
    {{- end }}
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
{{if $chain_config.excluded_sequences}}excluded_sequences = {{or $chain_config.excluded_sequences "[]"}}{{end}}
{{ end }}{{ end }}{{ end }}{{ end }}
