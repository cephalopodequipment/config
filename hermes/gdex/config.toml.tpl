[global]
strategy = 'packets'
log_level = 'debug'
filter = true
clear_packets_interval = 20
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
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "hub/relayer/min-gas-prices" "0.1" }}, denom = 'uatom' }
max_gas = {{ keyOrDefault "hub/relayer/max-gas" "3000000" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }

[chains.packet_filter]
policy = 'allow'
# akash, crypto-org, emoney, iris, ixo, juno, microtick, persistence, regen, sentinel, starname
list = [['transfer', 'channel-184'], ['transfer', 'channel-187'], ['transfer', 'channel-202'], ['transfer', 'channel-182'], ['transfer', 'channel-204'], ['transfer', 'channel-207'], ['transfer', 'channel-201'], ['transfer', 'channel-190'], ['transfer', 'channel-185'], ['transfer', 'channel-186'], ['transfer', 'channel-158']]


[[chains]]
id='akashnet-2'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_akash_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_akash_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_akash_rpc" }}/websocket'
rpc_timeout = '8s'
account_prefix = 'akash'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "akash/relayer/min-gas-prices" "0.0001" }}, denom = 'uakt' }
max_gas = {{ keyOrDefault "akash/relayer/max-gas" "1000000" }}
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }

[chains.packet_filter]
policy = 'allow'
# cosmos-hub, crypto-org, emoney, iris, ixo, microtick, persistence, regen, sentinel, starname
list = [['transfer', 'channel-17'], ['transfer', 'channel-18'], ['transfer', 'channel-30'], ['transfer', 'channel-16'], ['transfer', 'channel-29'], ['transfer', 'channel-28'], ['transfer', 'channel-20'], ['transfer', 'channel-21'], ['transfer', 'channel-22'], ['transfer', 'channel-27']]


[[chains]]
id = 'sentinelhub-2'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_sentinel_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_sentinel_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_sentinel_rpc" }}/websocket'
rpc_timeout = '8s'
account_prefix = 'sent'
key_name = 'aw3'
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
# akash, cosmos-hub, crypto-org, emoney, iris, ixo, microtick, persistence, regen, starname
list = [['transfer', 'channel-10'], ['transfer', 'channel-12'], ['transfer', 'channel-13'], ['transfer', 'channel-43'], ['transfer', 'channel-9'], ['transfer', 'channel-42'], ['transfer', 'channel-41'], ['transfer', 'channel-15'], ['transfer', 'channel-11'], ['transfer', 'channel-40']]


[[chains]]
id = 'crypto-org-chain-mainnet-1'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_crypto_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_crypto_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_crypto_rpc" }}/websocket'
rpc_timeout = '8s'
account_prefix = 'cro'
key_name = 'aw3'
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
# akash, cosmos-hub, emoney, iris, ixo, microtick, persistence, regen, sentinel, starname
list = [['transfer', 'channel-24'], ['transfer', 'channel-27'], ['transfer', 'channel-42'], ['transfer', 'channel-23'], ['transfer', 'channel-41'], ['transfer', 'channel-40'], ['transfer', 'channel-29'], ['transfer', 'channel-25'], ['transfer', 'channel-26'], ['transfer', 'channel-39']]


[[chains]]
id = 'regen-1'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_rgn_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_rgn_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_rgn_rpc" }}/websocket'
rpc_timeout = '8s'
account_prefix = 'regen'
key_name = 'aw3'
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
# akash, cosmos-hub, crypto-org, emoney, iris, ixo, microtick, persistence, sentinel, starname
list = [['transfer', 'channel-10'], ['transfer', 'channel-11'], ['transfer', 'channel-12'], ['transfer', 'channel-35'], ['transfer', 'channel-9'], ['transfer', 'channel-31'], ['transfer', 'channel-30'], ['transfer', 'channel-14'], ['transfer', 'channel-15'], ['transfer', 'channel-29']]


[[chains]]
id = 'irishub-1'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_iris_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_iris_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_iris_rpc" }}/websocket'
rpc_timeout = '8s'
account_prefix = 'iaa'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "iris/relayer/min-gas-prices" "0.0001" }}, denom = 'uiris' }
max_gas = {{ keyOrDefault "iris/relayer/max-gas" "1000000" }}
max_tx_size = 1800000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }

[chains.packet_filter]
policy = 'allow'
# akash, cosmos-hub, crypto-org, emoney, ixo, microtick, persistence, regen, sentinel, starname
list = [['transfer', 'channel-11'], ['transfer', 'channel-12'], ['transfer', 'channel-13'], ['transfer', 'channel-25'], ['transfer', 'channel-24'], ['transfer', 'channel-22'], ['transfer', 'channel-15'], ['transfer', 'channel-16'], ['transfer', 'channel-17'], ['transfer', 'channel-21']]


[[chains]]
id = 'core-1'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_core_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_core_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_core_rpc" }}/websocket'
rpc_timeout = '8s'
account_prefix = 'persistence'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "core/relayer/min-gas-prices" "0.1" }}, denom = 'uxprt' }
max_gas = {{ keyOrDefault "core/relayer/max-gas" "1000000" }}
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }

[chains.packet_filter]
policy = 'allow'
# akash, cosmos-hub, crypto-org, emoney, iris, ixo, microtick, regen, sentinel, starname
list = [['transfer', 'channel-20'], ['transfer', 'channel-24'], ['transfer', 'channel-23'], ['transfer', 'channel-31'], ['transfer', 'channel-19'], ['transfer', 'channel-30'], ['transfer', 'channel-28'], ['transfer', 'channel-21'], ['transfer', 'channel-22'], ['transfer', 'channel-27']]


[[chains]]
id = 'iov-mainnet-ibc'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_iov_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_iov_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_iov_rpc" }}/websocket'
rpc_timeout = '8s'
account_prefix = 'star'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "iov/relayer/min-gas-prices" "0.1" }}, denom = 'uiov' }
max_gas = {{ keyOrDefault "iov/relayer/max-gas" "1000000" }}
max_msg_num = 15
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }

[chains.packet_filter]
policy = 'allow'
# akash, cosmos-hub, crypto-org, iris, ixo, microtick, persistence, regen, sentinel
list = [['transfer', 'channel-7'], ['transfer', 'channel-0'], ['transfer', 'channel-9'], ['transfer', 'channel-11'], ['transfer', 'channel-17'], ['transfer', 'channel-16'], ['transfer', 'channel-13'], ['transfer', 'channel-14'], ['transfer', 'channel-15']]


[[chains]]
id = 'impacthub-3'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_ixo_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_ixo_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_ixo_rpc" }}/websocket'
rpc_timeout = '8s'
account_prefix = 'ixo'
key_name = 'aw3'
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
# akash, cosmos-hub, crypto-org, iris, microtick, persistence, regen, sentinel, starname
list = [['transfer', 'channel-0'], ['transfer', 'channel-1'], ['transfer', 'channel-2'], ['transfer', 'channel-3'], ['transfer', 'channel-9'], ['transfer', 'channel-5'], ['transfer', 'channel-6'], ['transfer', 'channel-7'], ['transfer', 'channel-8']]


[[chains]]
id = 'microtick-1'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_mtm_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_mtm_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_mtm_rpc" }}/websocket'
rpc_timeout = '8s'
account_prefix = 'micro'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "mtm/relayer/min-gas-prices" "0.1" }}, denom = 'utick' }
max_gas = {{ keyOrDefault "mtm/relayer/max-gas" "1000000" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }

[chains.packet_filter]
policy = 'allow'
# akash, cosmos-hub, crypto-org, emoney, iris, ixo, persistence, regen, sentinel, starname
list = [['transfer', 'channel-5'], ['transfer', 'channel-6'], ['transfer', 'channel-7'], ['transfer', 'channel-17'], ['transfer', 'channel-8'], ['transfer', 'channel-15'], ['transfer', 'channel-9'], ['transfer', 'channel-10'], ['transfer', 'channel-11'], ['transfer', 'channel-13'], ['transfer', 'channel-4']]