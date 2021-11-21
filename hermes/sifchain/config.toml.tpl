[global]
strategy = 'packets'
log_level = 'debug'
filter = true
clear_packets_interval = 50
tx_confirmation = false

[rest]
enabled = true
host = '0.0.0.0'
port = 3000

[[chains]]
id              = 'cosmoshub-4'
rpc_addr        = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_hub_rpc" }}'
grpc_addr       = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_hub_grpc" }}'
websocket_addr  = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_hub_rpc" }}/websocket'
rpc_timeout     = '8s'
account_prefix  = 'cosmos'
key_name        = 'aw4'
store_prefix    = 'ibc'
memo_prefix     = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price       = { price = {{ keyOrDefault "hub/relayer/min-gas-prices" "0.0001" }}, denom = 'uatom' }
max_gas         = {{ keyOrDefault "hub/relayer/max-gas" "1000000" }}
max_msg_num     = 15
max_tx_size     = 180000
clock_drift     = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }

[chains.packet_filter]
policy  = 'allow'
list    = [['transfer', 'channel-192']]


[[chains]]
id = 'akashnet-2'
rpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_akash_rpc" }}'
grpc_addr = 'http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_akash_grpc" }}'
websocket_addr = 'ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_akash_rpc" }}/websocket'
rpc_timeout = '8s'
account_prefix = 'akash'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "akash/relayer/min-gas-prices" "0.0001" }}, denom = 'uakt' }
max_gas = {{ keyOrDefault "akash/relayer/max-gas" "1000000" }}
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-24']]


[[chains]]
id='sentinelhub-2'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_sentinel_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_sentinel_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_sentinel_rpc" }}/websocket'
rpc_timeout='8s'
account_prefix='sent'
key_name='aw4'
store_prefix='ibc'
gas_price = { price = 0.05, denom = 'udvpn' }
max_gas=1000000
max_msg_num=15
clock_drift='7200s'
trusting_period='14days'
trust_threshold = { numerator = '1', denominator = '3' }

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-36']]


[[chains]]
id='crypto-org-chain-mainnet-1'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_crypto_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_crypto_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_crypto_rpc" }}/websocket'
rpc_timeout='8s'
account_prefix='cro'
key_name='aw4'
store_prefix='ibc'
memo_prefix='Connect the Interchain. Stake with Cephalopod 🐙'
gas_price={ price = {{ keyOrDefault "crypto/relayer/min-gas-prices" "0.0001" }}, denom = 'basecro' }
max_gas={{ keyOrDefault "crypto/relayer/max-gas" "1000000" }}
max_msg_num=15
max_tx_size=450000
clock_drift='7200s'
trusting_period='14days'
trust_threshold = { numerator = '1', denominator = '3' }

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-33']]


[[chains]]
id='regen-1'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_rgn_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_rgn_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_rgn_rpc" }}/websocket'
rpc_timeout='8s'
account_prefix='regen'
key_name='aw4'
store_prefix='ibc'
gas_price = { price = 0.02, denom = 'uregen' }
max_gas=800000
max_msg_num=15
max_tx_size=180000
clock_drift='7200s'
trusting_period='14days'
trust_threshold = { numerator = '1', denominator = '3' }

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-28']]


[[chains]]
id='core-1'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_core_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_core_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_core_rpc" }}/websocket'
rpc_timeout='8s'
account_prefix='persistence'
key_name='aw4'
store_prefix='ibc'
gas_price = { price = 0.001, denom = 'uxprt' }
max_gas=1000000
max_tx_size=180000
clock_drift='7200s'
trusting_period='14days'
trust_threshold = { numerator = '1', denominator = '3' }

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-26']]


[[chains]]
id='osmosis-1'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_osmo_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_osmo_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_osmo_rpc" }}/websocket'
rpc_timeout='8s'
account_prefix='osmo'
key_name='aw2'
store_prefix='ibc'
gas_price = { price = 0.001, denom = 'uosmo' }
max_gas=2000000
max_msg_num=8
clock_drift='7200s'
trusting_period='10days'
trust_threshold = { numerator = '1', denominator = '3' }

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-47']]


[[chains]]
id='juno-1'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_juno_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_juno_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_juno_rpc" }}/websocket'
rpc_timeout='8s'
account_prefix='juno'
key_name='aw2'
store_prefix='ibc'
gas_price = { price = 0.02, denom = 'ujuno' }
max_gas=1000000
max_msg_num=15
max_tx_size=450000
clock_drift='7200s'
trusting_period='14days'
trust_threshold = { numerator = '1', denominator = '3' }

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-5']]


[[chains]]
id='impacthub-3'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_ixo_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_ixo_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_ixo_rpc" }}/websocket'
rpc_timeout='8s'
account_prefix='ixo'
key_name='aw3'
store_prefix='ibc'
gas_price = { price = 0.0001, denom = 'uixo' }
max_gas=1500000
max_msg_num=15
max_tx_size=180000
clock_drift='7200s'
trusting_period='14days'
trust_threshold = { numerator = '1', denominator = '3' }

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-11']]


[[chains]]
id='emoney-3'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_emoney_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_emoney_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_emoney_rpc" }}/websocket'
rpc_timeout='8s'
account_prefix='emoney'
key_name = 'aw4'
store_prefix='ibc'
max_tx_size=180000
max_msg_num=15
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ keyOrDefault "emoney/relayer/min-gas-prices" "0.1" }}, denom = 'ungm' }
max_gas = {{ keyOrDefault "emoney/relayer/max-gas" "1000000" }}
clock_drift='70s'
trusting_period='10days'
trust_threshold={ numerator = '1', denominator = '3' }

[chains.packet_filter]
policy='allow'
list=[['transfer', 'channel-14']]


[[chains]]
id='sifchain-1'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_sif_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_sif_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_sif_rpc" }}/websocket'
rpc_timeout='8s'
account_prefix='sif'
key_name='aw4'
store_prefix='ibc'
gas_price = { price = 1000000000000, denom = 'rowan' }
max_gas=3000000
max_msg_num=15
max_tx_size=180000
clock_drift='7200s'
trusting_period='14days'
trust_threshold = { numerator = '1', denominator = '3' }

[chains.packet_filter]
policy = 'allow'
# cosmoshub, akash, crypto-org, iris, persistence, regen, sentinel, regen, osmosis, juno, ixo, emoney
list = [['transfer', 'channel-0'], ['transfer', 'channel-2'], ['transfer', 'channel-9'], ['transfer', 'channel-8'], ['transfer', 'channel-7'], ['transfer', 'channel-1'], ['transfer', 'channel-10'], ['transfer', 'channel-17'], ['transfer', 'channel-13'], ['transfer', 'channel-14'], ['transfer', 'channel-15'], ['transfer', 'channel-19']]
