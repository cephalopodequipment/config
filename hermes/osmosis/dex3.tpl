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
clear_interval = 71
clear_on_start = true
tx_confirmation = false

{{ with $ports := key "ports/relay-hub1" | parseJSON }}

[rest]
enabled = true
host = '0.0.0.0'
port = {{ $ports.hermes_osmosis2 }}

[[chains]]
id = 'core-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.core0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.core0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.core0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'persistence'
key_name = 'aw2'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/core/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uxprt' }
max_gas = {{ key "networks/core/relayer/hermes.max-gas" }}
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-6']]}

[[chains]]
id = 'iov-mainnet-ibc'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.iov0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.iov0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.iov0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'star'
key_name = 'aw2'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/iov-mainnet-ibc/relayer/base.minimum-gas-prices" }}, denom = 'uiov' }
max_gas = {{ key "networks/iov-mainnet-ibc/relayer/hermes.max-gas"}}
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-2']]}

[[chains]]
id = 'impacthub-3'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.impacthub0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.impacthub0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.impacthub0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'ixo'
key_name = 'aw2'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/impacthub/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uixo' }
max_gas = {{ key "networks/impacthub/relayer/hermes.max-gas" }}
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-4']]}

[[chains]]
id = 'juno-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.juno0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.juno0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.juno0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'juno'
key_name = 'aw2'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/juno/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'ujuno' }
max_gas = {{ key "networks/juno/relayer/hermes.max-gas" }}
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-0']]}

[[chains]]
id = 'osmosis-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.osmosis1 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.osmosis1 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.osmosis1 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'osmo'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/osmosis/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uosmo' }
max_gas = {{ key "networks/osmosis/relayer/hermes.max-gas" }}
clock_drift = '7200s'
trusting_period = '10days'
trust_threshold = { numerator = '1', denominator = '3' }
## core, iov, juno, impacthub
packet_filter = { policy = 'allow', list = [['transfer','channel-4'],['transfer','channel-15'],['transfer','channel-38'],['transfer','channel-42']]}

{{ end }}