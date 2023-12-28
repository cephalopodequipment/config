[global]
log_level = "info"

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
clear_interval = {{ env "CLEAR_INTERVAL" }}
clear_on_start = true
tx_confirmation = true

[rest]
enabled = true
host = '0.0.0.0'
port = 3000

[telemetry]
enabled = true
host = '0.0.0.0'
port = 3001

[telemetry.buckets]
latency_submitted = { start = 1000, end = 100000, buckets = 9 }
latency_confirmed = { start = 200, end = 20000, buckets = 9 }

[[ chains ]]
id = 'sifchain-1'
rpc_addr = '{{ env "SIFCHAIN_RPC" }}'
grpc_addr = '{{ env "SIFCHAIN_GRPC" }}'
event_source = { mode = 'pull', interval = '1s' }
rpc_timeout = '8s'
trusted_node = false
account_prefix = 'sif'
key_name = '{{ env "SIFCHAIN_AW_KEY" }}'
address_type = { derivation = 'cosmos' }
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Informal 🐙'
gas_price = {{ env "SIFCHAIN_GAS_PRICE" }}
max_gas = {{ env "SIFCHAIN_MAX_GAS" }}
ccv_consumer_chain = false
max_msg_num = 15
gas_multiplier = 1.2
max_tx_size = 2097152
clock_drift = '120s'
trusting_period = '14days'
trust_threshold = { numerator = '2', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-17']] }


[[ chains ]]
id = 'osmosis-1'
rpc_addr = '{{ env "OSMO_RPC" }}'
grpc_addr = '{{ env "OSMO_GRPC" }}'
event_source = { mode = 'pull', interval = '1s' }
rpc_timeout = '8s'
trusted_node = false
account_prefix = 'osmo'
key_name = '{{ env "OSMO_AW_KEY" }}'
address_type = { derivation = 'cosmos' }
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Informal 🐙'
gas_price = {{ env "OSMO_GAS_PRICE" }}
max_gas = {{ env "OSMO_MAX_GAS" }}
ccv_consumer_chain = false
max_msg_num = 15
gas_multiplier = 1.2
max_tx_size = 2097152
clock_drift = '120s'
trusting_period = '14days'
trust_threshold = { numerator = '2', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-47']] }


