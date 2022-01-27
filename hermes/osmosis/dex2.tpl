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


[[chains]]
id = 'cosmoshub-4'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_hub_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_hub_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_hub_rpc" }}/websocket'
rpc_timeout = '8s'
account_prefix = 'cosmos'
key_name = 'aw2'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "hub/relayer/min-gas-prices" "0.0001" }}, denom = 'uatom' }
max_gas = {{ keyOrDefault "hub/relayer/max-gas" "1000000" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-141']]}


[[chains]]
id = 'osmosis-1'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_osmo_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_osmo_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_osmo_rpc" }}/websocket'
rpc_timeout = '8s'
account_prefix = 'osmo'
key_name = 'aw2'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "osmo/relayer/min-gas-prices" "0.0001" }}, denom = 'uosmo' }
max_gas = {{ keyOrDefault "osmo/relayer/max-gas" "1000000" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '10days'
trust_threshold = { numerator = '1', denominator = '3' }
## akash, sentinel, crypto, regen, iris, iov, persistence, cosmoshub, juno, ixo
packet_filter = { policy = 'allow', list = [['transfer', 'channel-0']]}