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
host = '0.0.0.0'
port = {{ env "NOMAD_PORT_prom" }}

{{ with $ports := key "ports/prod0" | parseJSON }}


[[chains]]
id = 'osmosis-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.osmosis_relayer0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.osmosis_relayer0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.osmosis_relayer0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'osmo'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/osmosis/hermes.gas_price" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uosmo' }
max_gas = {{ key "networks/osmosis/hermes.max_gas" }}
max_msg_num = 15
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '10days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-47']]}


[[chains]]
id = 'cosmoshub-4'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.cosmoshub_relayer0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.cosmoshub_relayer0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.cosmoshub_relayer0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'cosmos'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/cosmoshub/hermes.gas_price" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uatom' }
max_gas = {{ key "networks/cosmoshub/hermes.max_gas" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-192']]}


[[chains]]
id = 'sifchain-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.sifchain_relayer0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.sifchain_relayer0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.sifchain_relayer0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'sif'
key_name = 'aw2'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/sifchain/hermes.gas_price" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'rowan' }
max_gas = {{ key "networks/sifchain/hermes.max_gas" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# cosmoshub
# osmosis
packet_filter = { policy = 'allow', list = [['transfer', 'channel-0'],
                                            ['transfer', 'channel-17']]}

{{ end }}