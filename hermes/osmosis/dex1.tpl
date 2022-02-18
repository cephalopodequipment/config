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

{{ with $ports := key "ports/relayer" }}

[[chains]]
id='akashnet-2'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.akashnet-relay-1 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.akashnet-relay-1 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.akashnet-relay-1 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'akash'
key_name = 'aw2'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "akash/relayer/min-gas-prices" "0.0001" }}, denom = 'uakt' }
max_gas = {{ keyOrDefault "akash/relayer/max-gas" "1000000" }}
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-9']]}


[[chains]]
id = 'sentinelhub-2'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.sentinelhub-relay-1 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.sentinelhub-relay-1 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.sentinelhub-relay-1 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'sent'
key_name = 'aw2'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "sentinel/relayer/min-gas-prices" "0.0001" }}, denom = 'udvpn' }
max_gas = {{ keyOrDefault "sentinel/relayer/max-gas" "1000000" }}
max_msg_num = 15
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-0']]}


[[chains]]
id = 'crypto-org-chain-mainnet-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.crypto-relay-1 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.crypto-relay-1 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.crypto-relay-1 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'cro'
key_name = 'aw2'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "crypto/relayer/min-gas-prices" "0.0001" }}, denom = 'basecro' }
max_gas = {{ keyOrDefault "crypto/relayer/max-gas" "1000000" }}
max_msg_num = 15
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-10']]}


[[chains]]
id = 'regen-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.regen-relay-1 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.regen-relay-1 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.regen-relay-1 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'regen'
key_name = 'aw2'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "regen/relayer/min-gas-prices" "0.0001" }}, denom = 'uregen' }
max_gas = {{ keyOrDefault "regen/relayer/max-gas" "1000000" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-1']]}


[[chains]]
id = 'core-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.core-relay-1 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.core-relay-1 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.core-relay-1 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'persistence'
key_name = 'aw2'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "core/relayer/min-gas-prices" "0.0001" }}, denom = 'uxprt' }
max_gas = {{ keyOrDefault "core/relayer/max-gas" "1000000" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-6']]}


[[chains]]
id = 'irishub-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.irishub-relay-1 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.irishub-relay-1 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.irishub-relay-1 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'iaa'
key_name = 'aw2'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "iris/relayer/min-gas-prices" "0.0001" }}, denom = 'uiris' }
max_gas = {{ keyOrDefault "iris/relayer/max-gas" "1000000" }}
max_msg_num=15
max_tx_size = 1800000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-3']]}


[[chains]]
id = 'iov-mainnet-ibc'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.iov-relay-1 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.iov-relay-1 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.iov-relay-1 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'star'
key_name = 'aw2'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "iov/relayer/min-gas-prices" "0.0001" }}, denom = 'uiov' }
max_gas = {{ keyOrDefault "iov/relayer/max-gas" "1000000" }}
max_msg_num = 15
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-2']]}


[[chains]]
id = 'impacthub-3'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.impacthub-relay-1 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.impacthub-relay-1 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.impacthub-relay-1 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'ixo'
key_name = 'aw2'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "ixo/relayer/min-gas-prices" "0.1" }}, denom = 'uixo' }
max_gas = {{ keyOrDefault "ixo/relayer/max-gas" "1000000" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-4']]}


[[chains]]
id = 'juno-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.juno-relay-1 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.juno-relay-1 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.juno-relay-1 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'juno'
key_name = 'aw2'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "juno/relayer/min-gas-prices" "0.0001" }}, denom = 'ujuno' }
max_gas = {{ keyOrDefault "juno/relayer/max-gas" "1000000" }}
max_msg_num = 15
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-0']]}


[[chains]]
id = 'osmosis-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.osmosis-relay-1 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.osmosis-relay-1 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.hermes-osmo.osmosis-relay-1 }}0/websocket'
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
packet_filter = { policy = 'allow', list = [['transfer', 'channel-1'],['transfer', 'channel-2'],['transfer', 'channel-5'],['transfer', 'channel-8'],['transfer', 'channel-6'],['transfer', 'channel-15'],['transfer', 'channel-4'],['transfer', 'channel-42'],['transfer','channel-38']]}

{{ end }}