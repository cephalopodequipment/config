[global]
strategy = 'packets'
filter = true
log_level='debug'
clear_packets_interval = 20
tx_confirmation = true

[rest]
enabled = true
host    = '0.0.0.0'
port    = 3000


[[chains]]
id='cosmoshub-4'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_hub_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_hub_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_hub_rpc" }}/websocket'
rpc_timeout='8s'
account_prefix='cosmos'
key_name='aw2'
store_prefix='ibc'
gas_price = { price = 0.0001, denom = 'uatom' }
max_gas=1000000
max_msg_num=15
max_tx_size=180000
clock_drift='7200s'
trusting_period='14days'

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-141']]

[chains.trust_threshold]
numerator='1'
denominator='3'


[[chains]]
id='akashnet-2'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_akash_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_akash_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_akash_rpc" }}/websocket'
rpc_timeout='8s'
account_prefix='akash'
key_name='aw2'
store_prefix='ibc'
gas_price = { price = 0.001, denom = 'uakt' }
max_gas=1000000
clock_drift='7200s'
trusting_period='14days'

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-9']]

[chains.trust_threshold]
numerator='1'
denominator='3'


[[chains]]
id='sentinelhub-2'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_dvpn_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_dvpn_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_dvpn_rpc" }}/websocket'
rpc_timeout='8s'
account_prefix='sent'
key_name='aw2'
store_prefix='ibc'
gas_price = { price = 0.05, denom = 'udvpn' }
max_gas=1000000
max_msg_num=15
clock_drift='7200s'
trusting_period='14days'

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-0']]

[chains.trust_threshold]
numerator='1'
denominator='3'


[[chains]]
id='crypto-org-chain-mainnet-1'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_crypto_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_crypto_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_crypto_rpc" }}/websocket'
rpc_timeout='8s'
account_prefix='cro'
key_name='aw2'
store_prefix='ibc'
gas_price = { price = 0.03, denom = 'basecro' }
max_gas=1200000
max_msg_num=15
max_tx_size=450000
clock_drift='7200s'
trusting_period='14days'

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-10']]

[chains.trust_threshold]
numerator='1'
denominator='3'


[[chains]]
id='regen-1'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_rgn_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_rgn_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_rgn_rpc" }}/websocket'
rpc_timeout='8s'
account_prefix='regen'
key_name='aw2'
store_prefix='ibc'
gas_price = { price = 0.02, denom = 'uregen' }
max_gas=800000
max_msg_num=15
max_tx_size=180000
clock_drift='7200s'
trusting_period='14days'

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-1']]

[chains.trust_threshold]
numerator='1'
denominator='3'


[[chains]]
id='irishub-1'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_iris_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_iris_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_iris_rpc" }}/websocket'
rpc_timeout='8s'
account_prefix='iaa'
key_name='aw2'
store_prefix='ibc'
gas_price = { price = 0.005, denom = 'uiris' }
max_gas=800000
max_msg_num=15
max_tx_size=1800000
clock_drift='7200s'
trusting_period='14days'

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-3']]

[chains.trust_threshold]
numerator='1'
denominator='3'


[[chains]]
id='core-1'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_core_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_core_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_core_rpc" }}/websocket'
rpc_timeout='8s'
account_prefix='persistence'
key_name='aw2'
store_prefix='ibc'
gas_price = { price = 0.001, denom = 'uxprt' }
max_gas=1000000
max_msg_num=15
max_tx_size=180000
clock_drift='7200s'
trusting_period='14days'

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-6']]

[chains.trust_threshold]
numerator='1'
denominator='3'


[[chains]]
id='iov-mainnet-ibc'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_iov_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_iov_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_iov_rpc" }}/websocket'
rpc_timeout='8s'
account_prefix='star'
key_name='aw2'
store_prefix='ibc'
gas_price = { price = 0.02, denom = 'uiov' }
max_gas=1100000
max_msg_num=15
max_tx_size=450000
clock_drift='7200s'
trusting_period='14days'

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-2']]

[chains.trust_threshold]
numerator='1'
denominator='3'


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

#[chains.packet_filter]
#policy = 'allow'
list = [['transfer', 'channel-4']]


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

[chains.packet_filter]
policy = 'allow'
list = [['transfer', 'channel-0']]

[chains.trust_threshold]
numerator='1'
denominator='3'


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
trusting_period='14days'

[chains.packet_filter]
policy = 'allow'
## akash, sentinel, crypto, regen, iris, iov, persistence, cosmoshub, juno, ixo
list = [['transfer', 'channel-1'],['transfer', 'channel-2'],['transfer', 'channel-5'],['transfer', 'channel-8'],['transfer', 'channel-6'],['transfer', 'channel-15'],['transfer', 'channel-4'],['transfer', 'channel-0'],['transfer', 'channel-42'],['transfer','channel-38']]

[chains.trust_threshold]
numerator='1'
denominator='3'
