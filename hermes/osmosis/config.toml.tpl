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
filter = true
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

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-141']]


[[chains]]
id='akashnet-2'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_akash_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_akash_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_akash_rpc" }}/websocket'
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

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-9']]


[[chains]]
id = 'sentinelhub-2'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_sentinel_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_sentinel_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_sentinel_rpc" }}/websocket'
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

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-0']]


[[chains]]
id = 'crypto-org-chain-mainnet-1'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_crypto_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_crypto_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_crypto_rpc" }}/websocket'
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

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-10']]


[[chains]]
id = 'regen-1'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_rgn_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_rgn_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_rgn_rpc" }}/websocket'
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

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-1']]


[[chains]]
id = 'core-1'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_core_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_core_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_core_rpc" }}/websocket'
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

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-6']]


[[chains]]
id = 'irishub-1'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_iris_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_iris_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_iris_rpc" }}/websocket'
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

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-3']]


[[chains]]
id = 'iov-mainnet-ibc'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_iov_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_iov_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_iov_rpc" }}/websocket'
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

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-2']]


[[chains]]
id = 'impacthub-3'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_ixo_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_ixo_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_ixo_rpc" }}/websocket'
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

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-4']]


[[chains]]
id = 'juno-1'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_juno_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_juno_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_juno_rpc" }}/websocket'
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

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-0']]


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

[chains.packet_filter]
policy = 'allow'
## akash, sentinel, crypto, regen, iris, iov, persistence, cosmoshub, juno, ixo
list = [['transfer', 'channel-1'],['transfer', 'channel-2'],['transfer', 'channel-5'],['transfer', 'channel-8'],['transfer', 'channel-6'],['transfer', 'channel-15'],['transfer', 'channel-4'],['transfer', 'channel-0'],['transfer', 'channel-42'],['transfer','channel-38']]
