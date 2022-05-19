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

{{ with $ports := key "ports/relay-hub0" | parseJSON }}

[[chains]]
id = 'regen-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.regen0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.regen0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.regen0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'regen'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/regen/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uregen' }
max_gas = {{ key "networks/regen/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-28']]}


[[chains]]
id = 'juno-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.juno_relayer0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.juno_relayer0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.juno_relayer0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'juno'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/juno/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'ujuno' }
max_gas = {{ key "networks/juno/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-5']]}

[[chains]]
id = 'emoney-3'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.emoney0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.emoney0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.emoney0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'emoney'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/emoney/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'ungm' }
max_gas = {{ key "networks/emoney/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '70s'
trusting_period = '10days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-14']]}

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
gas_price = { price = {{ key "networks/osmosis/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uosmo' }
max_gas = {{ key "networks/osmosis/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '10days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-47']]}

[[chains]]
id = 'irishub-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.irishub0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.irishub0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.irishub0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'iaa'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/irishub/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uiris' }
max_gas = {{ key "networks/irishub/relayer/hermes.max-gas" }}
max_msg_num=15
max_tx_size = 1800000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-19']]}

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
gas_price = { price = {{ key "networks/sifchain/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'rowan' }
max_gas = {{ key "networks/sifchain/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# regen, osmosis, juno, emoney, irishub
packet_filter = { policy = 'allow', list = [['transfer', 'channel-10'],['transfer', 'channel-17'],['transfer', 'channel-14'],['transfer', 'channel-19'],['transfer', 'channel-8']]}

{{ end }}
