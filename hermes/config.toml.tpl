[global]
log_level = 'debug'

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
port = {{ env "NOMAD_PORT_rest" }}

[telemetry]
enabled = true
host    = '0.0.0.0'
port    = {{ env "NOMAD_PORT_prom" }}

{{ $path := env "CONSUL_PATH" }}
{{ range $key, $pairs := tree $path | byKey }}
[[chains]]
id = {{ $pairs.chain_id.Value }}
rpc_addr = 'http://{{ range service $pairs.node_service.Value }}{{ .Address }}:{{ index .ServiceMeta "port-rpc" }}{{end}}'
grpc_addr = 'http://{{ range service $pairs.node_service.Value }}{{ .Address }}:{{ index .ServiceMeta "port-grpc" }}{{end}}'
websocket_addr = 'ws://{{ range service $pairs.node_service.Value }}{{ .Address }}:{{ index .ServiceMeta "port-rpc" }}{{end}}/websocket'
rpc_timeout = '8s'
account_prefix = {{ $pairs.account_prefix.Value }}
key_name = {{ $pairs.chain_id.Value }}
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Informal'
gas_price = {{ $pairs.gas_price.Value }}
max_gas = {{ $pairs.max_gas.Value }}
max_msg_num = {{ $pairs.max_msg_num.Value }}
gas_multiplier = {{ $pairs.gas_multiplier.Value }}
max_tx_size = {{ $pairs.max_tx_size.Value }}
clock_drift = {{ $pairs.clock_drift.Value }}
trusting_period = {{ $pairs.trusting_period.Value }}
trust_threshold = {{ $pairs.trust_threshold.Value }}
packet_filter = { policy = {{ $pairs.policy.Value }}, list = [["transfer", {{ $pairs.channel_id.Value }}]]}
{{ end }}