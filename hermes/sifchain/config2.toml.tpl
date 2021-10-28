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
id = 'columbus-5'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_terra_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_terra_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_terra_rpc" }}/websocket'
rpc_timeout = '8s'
account_prefix = 'terra'
key_name = ''
memo_prefix = 'Connecting the Interchain. Delegate to Cephalopod. 🐙'
store_prefix = 'ibc'
gas_price = { price = 0.001, denom = 'uluna' }
max_gas = 1000000
max_msg_num=15
clock_drift ='7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }

[chains.packet_filter]
policy = 'allow'
list = [['transfer', '']]


[[chains]]
id='sifchain-1'
rpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_sif_rpc" }}'
grpc_addr='http://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_sif_grpc" }}'
websocket_addr='ws://{{ env "EXTERNAL_IP" }}:{{ env "NOMAD_PORT_sif_rpc" }}/websocket'
rpc_timeout='8s'
account_prefix='sif'
key_name='aw4'
store_prefix='ibc'
gas_price = { price = 1000000, denom = 'rowan' }
max_gas=5000000
max_msg_num=15
max_tx_size=180000
clock_drift='7200s'
trusting_period='14days'
trust_threshold = { numerator = '1', denominator = '3' }

[chains.packet_filter]
policy = 'allow'
# cosmoshub, akash, crypto-org, iris, persistence, regen, sentinel, regen, osmosis, juno, ixo, terra
list = [['transfer', 'channel-0'], ['transfer', 'channel-2'], ['transfer', 'channel-9'], ['transfer', 'channel-8'], ['transfer', 'channel-7'], ['transfer', 'channel-1'], ['transfer', 'channel-10'], ['transfer', 'channel-17'], ['transfer', 'channel-13'], ['transfer', 'channel-14'], ['transfer', 'channel-15'], ['transfer', 'channel-']]
