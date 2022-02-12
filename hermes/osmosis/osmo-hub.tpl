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

{{ with $ports := key "ports/hermes-osmo-hub" | parseJSON }}

[[chains]]
id = 'cosmoshub-4'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ $ports.hub }}0'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ $ports.hub }}2'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ $ports.hub }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'cosmos'
key_name = 'aw2'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "networks/cosmoshub/relayer/base.minimum-gas-prices" "0.0001" }}, denom = 'uatom' }
max_gas = {{ keyOrDefault "networks/cosmoshub/relayer/hermes.max-gas" "1000000" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-141']]}


[[chains]]
id = 'osmosis-1'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ $ports.osmo }}0'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ $ports.osmo }}2'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ $ports.osmo }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'osmo'
key_name = 'aw2'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "networks/osmosis/relayer/base.minimum-gas-prices" "0.0001" }}, denom = 'uosmo' }
max_gas = {{ keyOrDefault  "networks/osmosis/relayer/hermes.max-gas" "1000000" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '10days'
trust_threshold = { numerator = '1', denominator = '3' }
## akash, sentinel, crypto, regen, iris, iov, persistence, cosmoshub, juno, ixo
packet_filter = { policy = 'allow', list = [['transfer', 'channel-0']]}

{{ end }}