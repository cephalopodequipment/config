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
clear_interval = 101
clear_on_start = true
tx_confirmation = false

{{ with $ports := key "ports/relay-hub0" | parseJSON }}

[rest]
enabled = true
host = '0.0.0.0'
port = {{ $ports.hermes_emeris0 }}

[[chains]]
id = 'cosmoshub-4'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.cosmoshub0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.cosmoshub0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.cosmoshub0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'cosmos'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/cosmoshub/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uatom' }
max_gas = {{ key "networks/cosmoshub/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# emoney, core, impacthub, iov-mainnet-ibc
packet_filter = { policy = 'allow', list = [['transfer','channel-201'],['transfer','channel-202'],['transfer','channel-190'],['transfer','channel-204'],['transfer','channel-158']]}

[[chains]]
id = 'emoney-3'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.emoney0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.emoney0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.emoney0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'emoney'
key_name = 'aw3'
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
# cosmoshub, core, impacthub, iov-mainnet-ibc
packet_filter = { policy = 'allow', list = [['transfer','channel-201'],['transfer','channel-202'],['transfer','channel-190'],['transfer','channel-204'],['transfer','channel-158']]}

{{ end }}

{{ with $ports := key "ports/relay-hub1" | parseJSON }}

[[chains]]
id = 'core-1'
rpc_addr = 'http://{{ env "HOST_IP_2" }}:{{ $ports.core0 }}0'
grpc_addr = 'http://{{ env "HOST_IP_2" }}:{{ $ports.core0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP_2" }}:{{ $ports.core0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'persistence'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/core/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uxprt' }
max_gas = {{ key "networks/core/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# akash, cosmos-hub, crypto-org, emoney, iris, ixo, microtick, regen, sentinel, starname
packet_filter = { policy = 'allow', list = [['transfer', 'channel-20'], ['transfer', 'channel-24'], ['transfer', 'channel-23'], ['transfer', 'channel-31'], ['transfer', 'channel-19'], ['transfer', 'channel-30'], ['transfer', 'channel-28'], ['transfer', 'channel-21'], ['transfer', 'channel-22'], ['transfer', 'channel-27']]}

[[chains]]
id = 'impacthub-3'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.impacthub0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.impacthub0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.impacthub0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'ixo'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/impacthub/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uixo' }
max_gas = {{ key "networks/impacthub/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-11']]}

{{ end }}