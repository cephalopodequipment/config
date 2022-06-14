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
tx_confirmation = true

[rest]
enabled = true
host = '0.0.0.0'
port = {{ env "NOMAD_PORT_rest" }}

[telemetry]
enabled = true
host = '0.0.0.0'
port = {{ env "NOMAD_PORT_prom" }}

{{ with $ports := key "ports/prod1" | parseJSON }}

[[chains]]
id = 'cosmoshub-4'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.cosmoshub_relayer1 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.cosmoshub_relayer1 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.cosmoshub_relayer1 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'cosmos'
key_name = 'aw5'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/cosmoshub/hermes.gas_price" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uatom' }
max_gas = {{ key "networks/cosmoshub/hermes.max_gas" }}
max_msg_num = 50
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# core
# impacthub
# iov-mainnet-ibc
packet_filter = { policy = 'allow', list = [['transfer','channel-190'],
                                            ['transfer','channel-184'],
                                            ['transfer','channel-158']]}


[[chains]]
id='akashnet-2'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.akashnet_relayer0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.akashnet_relayer0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.akashnet_relayer0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'akash'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/akashnet/hermes.gas_price" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uakt' }
max_gas = {{ key "networks/akashnet/hermes.max-gas" }}
max_msg_num = 30
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer','channel-17']]}


[[chains]]
id = 'core-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.core_relayer0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.core_relayer0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.core_relayer0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'persistence'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/core/hermes.gas_price" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uxprt' }
max_gas = {{ key "networks/core/hermes.max_gas" }}
max_msg_num = 30
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-24']]}


[[chains]]
id = 'iov-mainnet-ibc'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.iov_relayer0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.iov_relayer0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.iov_relayer0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'star'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/iov-mainnet-ibc/hermes.gas_price" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uiov' }
max_gas = {{ key "networks/iov-mainnet-ibc/hermes.max_gas" }}
max_msg_num = 30
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-0']]}

{{ end }}