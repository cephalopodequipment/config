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
id='cosmoshub-4'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_hub_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_hub_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_hub_rpc" }}/websocket'
rpc_timeout='8s'
account_prefix='cosmos'
key_name='aw3'
store_prefix='ibc'
gas_price = { price = 0.0001, denom = 'uatom' }
max_gas=5000000
max_msg_num=15
max_tx_size=180000
clock_drift='7200s'
trusting_period='14days'

[chains.packet_filter]
policy = 'allow'
# akash, crypto-org, iris, ixo, microtick, persistence, regen, sentinel, starname
list = [['transfer', 'channel-184'], ['transfer', 'channel-187'], ['transfer', 'channel-182'], ['transfer', 'channel-204'], ['transfer', 'channel-201'], ['transfer', 'channel-190'], ['transfer', 'channel-185'], ['transfer', 'channel-186'], ['transfer', 'channel-158']]

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
key_name='aw3'
store_prefix='ibc'
gas_price = { price = 0.001, denom = 'uakt' }
max_gas=1000000
clock_drift='7200s'
trusting_period='14days'

[chains.packet_filter]
policy = 'allow'
# cosmos-hub, crypto-org, iris, ixo, microtick, persistence, regen, sentinel, starname
list = [['transfer', 'channel-17'], ['transfer', 'channel-18'], ['transfer', 'channel-16'], ['transfer', 'channel-29'], ['transfer', 'channel-28'], ['transfer', 'channel-20'], ['transfer', 'channel-21'], ['transfer', 'channel-22'], ['transfer', 'channel-27']]

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
key_name='aw3'
store_prefix='ibc'
gas_price = { price = 0.05, denom = 'udvpn' }
max_gas=1000000
max_msg_num=15
clock_drift='7200s'
trusting_period='14days'

[chains.packet_filter]
policy = 'allow'
# akash, cosmos-hub, crypto-org, iris, ixo, microtick, persistence, regen, starname
list = [['transfer', 'channel-10'], ['transfer', 'channel-12'], ['transfer', 'channel-13'], ['transfer', 'channel-9'], ['transfer', 'channel-42'], ['transfer', 'channel-41'], ['transfer', 'channel-15'], ['transfer', 'channel-11'], ['transfer', 'channel-40']]

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
key_name='aw3'
store_prefix='ibc'
gas_price = { price = 0.03, denom = 'basecro' }
max_gas=1200000
max_msg_num=15
max_tx_size=450000
clock_drift='7200s'
trusting_period='14days'

[chains.packet_filter]
policy = 'allow'
# akash, cosmos-hub, iris, ixo, microtick, persistence, regen, sentinel, starname
list = [['transfer', 'channel-24'], ['transfer', 'channel-27'], ['transfer', 'channel-23'], ['transfer', 'channel-41'], ['transfer', 'channel-40'], ['transfer', 'channel-29'], ['transfer', 'channel-25'], ['transfer', 'channel-26'], ['transfer', 'channel-39']]

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
key_name='aw3'
store_prefix='ibc'
gas_price = { price = 0.02, denom = 'uregen' }
max_gas=800000
max_msg_num=15
max_tx_size=180000
clock_drift='7200s'
trusting_period='14days'

[chains.packet_filter]
policy = 'allow'
# akash, cosmos-hub, crypto-org, iris, ixo, microtick, persistence, sentinel, starname
list = [['transfer', 'channel-10'], ['transfer', 'channel-11'], ['transfer', 'channel-12'], ['transfer', 'channel-9'], ['transfer', 'channel-31'], ['transfer', 'channel-30'], ['transfer', 'channel-14'], ['transfer', 'channel-15'], ['transfer', 'channel-29']]

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
key_name='aw3'
store_prefix='ibc'
gas_price = { price = 0.001, denom = 'uiris' }
max_gas=1500000
max_tx_size=1800000
clock_drift='7200s'
trusting_period='14days'

[chains.packet_filter]
policy = 'allow'
# akash, cosmos-hub, crypto-org, ixo, microtick, persistence, regen, sentinel, starname
list = [['transfer', 'channel-11'], ['transfer', 'channel-12'], ['transfer', 'channel-13'], ['transfer', 'channel-24'], ['transfer', 'channel-22'], ['transfer', 'channel-15'], ['transfer', 'channel-16'], ['transfer', 'channel-17'], ['transfer', 'channel-21']]

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
key_name='aw3'
store_prefix='ibc'
gas_price = { price = 0.001, denom = 'uxprt' }
max_gas=1000000
max_tx_size=180000
clock_drift='7200s'
trusting_period='14days'

[chains.packet_filter]
policy = 'allow'
# akash, cosmos-hub, crypto-org, iris, ixo, microtick, regen, sentinel, starname
list = [['transfer', 'channel-20'], ['transfer', 'channel-24'], ['transfer', 'channel-23'], ['transfer', 'channel-19'], ['transfer', 'channel-30'], ['transfer', 'channel-28'], ['transfer', 'channel-21'], ['transfer', 'channel-22'], ['transfer', 'channel-27']]

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
key_name='aw3'
store_prefix='ibc'
gas_price = { price = 0.02, denom = 'uiov' }
max_gas=1100000
max_msg_num=15
max_tx_size=450000
clock_drift='7200s'
trusting_period='14days'

[chains.packet_filter]
policy = 'allow'
# akash, cosmos-hub, crypto-org, iris, ixo, microtick, persistence, regen, sentinel
list = [['transfer', 'channel-7'], ['transfer', 'channel-0'], ['transfer', 'channel-9'], ['transfer', 'channel-11'], ['transfer', 'channel-17'], ['transfer', 'channel-16'], ['transfer', 'channel-13'], ['transfer', 'channel-14'], ['transfer', 'channel-15']]

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

[chains.packet_filter]
policy = 'allow'
# akash, cosmos-hub, crypto-org, iris, microtick, persistence, regen, sentinel, starname
list = [['transfer', 'channel-0'], ['transfer', 'channel-1'], ['transfer', 'channel-2'], ['transfer', 'channel-3'], ['transfer', 'channel-9'], ['transfer', 'channel-5'], ['transfer', 'channel-6'], ['transfer', 'channel-7'], ['transfer', 'channel-8']]

[chains.trust_threshold]
numerator='1'
denominator='3'


#[[chains]]
#id='microtick-1'
#rpc_addr='http://{{ env "RPC_ADDR" }}'
#grpc_addr='http://{{ env "GRPC_ADDR" }}'
#websocket_addr='ws://{{ env "RPC_ADDR" }}/websocket'
#rpc_timeout='8s'
#account_prefix='micro'
#key_name='aw3'
#store_prefix='ibc'
#gas_price = { price = 0.0001, denom = '' }
#max_gas=1500000
#max_msg_num=15
#max_tx_size=180000
#clock_drift='7200s'
#trusting_period='14days'

#[chains.packet_filter]
#policy = 'allow'
# akash, cosmos-hub, crypto-org, iris, ixo, persistence, regen, sentinel, starname
#list = [['transfer', 'channel-5'], ['transfer', 'channel-6'], ['transfer', 'channel-7'], ['transfer', 'channel-8'], ['transfer', 'channel-15'], ['transfer', 'channel-10'], ['transfer', 'channel-11'], ['transfer', 'channel-13'], ['transfer', 'channel-4']]
