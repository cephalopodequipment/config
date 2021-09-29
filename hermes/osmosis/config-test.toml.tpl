[global]
strategy = 'packets'
filter = true
log_level='debug'
clear_packets_interval = 20
tx_confirmation = false

[rest]
enabled = true
host    = '0.0.0.0'
port    = 3000


[[chains]]
id='cosmoshub-4'
rpc_addr='http://127.0.0.1:{{ env "NOMAD_PORT_hub_rpc" }}'
grpc_addr='http://127.0.0.1:{{ env "NOMAD_PORT_hub_grpc" }}'
websocket_addr='ws://127.0.0.1:{{ env "NOMAD_PORT_hub_rpc" }}/websocket'
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
id='osmosis-1'
rpc_addr='http://10.10.51.169:26657'
grpc_addr='http://10.10.51.169:9090'
websocket_addr='ws://10.10.51.169:26657/websocket'
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
## akash, sentinel, crypto, regen, iris, iov, persistence, cosmoshub
list = [['transfer', 'channel-1'],['transfer', 'channel-2'],['transfer', 'channel-5'],['transfer', 'channel-8'],['transfer', 'channel-6'],['transfer', 'channel-15'],['transfer', 'channel-4'],['transfer', 'channel-0']]

[chains.trust_threshold]
numerator='1'
denominator='3'
