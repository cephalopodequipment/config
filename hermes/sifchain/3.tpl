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
tx_confirmation = false

{{ with $ports := key "ports/relay-hub2" | parseJSON }}

[rest]
enabled = true
host = '0.0.0.0'
port = {{ $ports.hermes_sifchain3 }}

[[chains]]
id = 'columbus-5'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.terra0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.terra0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.terra0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'terra'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/columbus/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'usek' }
max_gas = {{ key "networks/columbus/relayer/hermes.max-gas" }}
max_msg_num = 50
max_tx_size = 650000
clock_drift = '5s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-7']]}


[[chains]]
id = 'sifchain-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.sifchain2 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.sifchain2 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.sifchain2 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'sif'
key_name = 'aw5'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/sifchain/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'rowan' }
max_gas = {{ key "networks/sifchain/relayer/hermes.max-gas" }}
max_msg_num = 50
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# core, impacthub
packet_filter = { policy = 'allow', list = [['transfer', 'channel-18']]}

{{ end }}