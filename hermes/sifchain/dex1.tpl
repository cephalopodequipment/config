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
clear_interval = 100
clear_on_start = true
tx_confirmation = false


[rest]
enabled = true
host = '0.0.0.0'
port = 3000

{{ with $ports := key "ports/relay-hub0" | parseJSON }}

[[chains]]
id = 'osmosis-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.osmosis0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.osmosis0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.osmosis0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'osmo'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "osmo/relayer/min-gas-prices" "0.0001" }}, denom = 'uosmo' }
max_gas = {{ keyOrDefault "osmo/relayer/max-gas" "1000000" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '10days'
trust_threshold = { numerator = '1', denominator = '3' }
# sifchain
packet_filter = { policy = 'allow', list = [['transfer','channel-47']]}


[[chains]]
id = 'sifchain-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.sifchain0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.sifchain0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.sifchain0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'sif'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "sifchain/relayer/min-gas-prices" "100000000000" }}, denom = 'rowan' }
max_gas = {{ keyOrDefault "sifchain/relayer/max-gas" "1000000" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# osmosis
packet_filter = { policy = 'allow', list = [['transfer','channel-47']]}

{{ end }}