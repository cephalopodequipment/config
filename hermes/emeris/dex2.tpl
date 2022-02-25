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
clear_interval = 101
clear_on_start = true
tx_confirmation = false

{{ with $ports := key "ports/relay-hub0" | parseJSON }}

[rest]
enabled = true
host = '0.0.0.0'
port = {{ $ports.hermes_emeris0 }}

[[chains]]
id = 'cosmoshub-4'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.cosmoshub0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.cosmoshub0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.cosmoshub0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'cosmos'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/cosmoshub/relayer/base.minimum-gas-prices" }}, denom = 'uatom' }
max_gas = {{ key "networks/cosmoshub/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# akash, crypto-org, emoney, iris, ixo, juno, microtick, persistence, regen, sentinel, starname
packet_filter = { policy = 'allow', list = [['transfer', 'channel-184'], ['transfer', 'channel-187'], ['transfer', 'channel-202'], ['transfer', 'channel-182'], ['transfer', 'channel-204'], ['transfer', 'channel-207'], ['transfer', 'channel-201'], ['transfer', 'channel-190'], ['transfer', 'channel-185'], ['transfer', 'channel-186'], ['transfer', 'channel-158']]}

[[chains]]
id='akashnet-2'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.akashnet0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.akashnet0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.akashnet0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'akash'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/akashnet/relayer/base.minimum-gas-prices" }}, denom = 'uakt' }
max_gas = {{ key "networks/akashnet/relayer/hermes.max-gas" }}
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# cosmos-hub, crypto-org, emoney, iris, ixo, microtick, persistence, regen, sentinel, starname
packet_filter = { policy = 'allow', list = [['transfer', 'channel-17'], ['transfer', 'channel-18'], ['transfer', 'channel-30'], ['transfer', 'channel-16'], ['transfer', 'channel-29'], ['transfer', 'channel-28'], ['transfer', 'channel-20'], ['transfer', 'channel-21'], ['transfer', 'channel-22'], ['transfer', 'channel-27']]}

[[chains]]
id = 'sentinelhub-2'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.sentinelhub0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.sentinelhub0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.sentinelhub0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'sent'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/sentinelhub/relayer/base.minimum-gas-prices" }}, denom = 'udvpn' }
max_gas = {{ key "networks/sentinelhub/relayer/hermes.max-gas" }}
max_msg_num = 15
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# akash, cosmos-hub, crypto-org, emoney, iris, ixo, microtick, persistence, regen, starname
packet_filter = { policy = 'allow', list = [['transfer', 'channel-10'], ['transfer', 'channel-12'], ['transfer', 'channel-13'], ['transfer', 'channel-43'], ['transfer', 'channel-9'], ['transfer', 'channel-42'], ['transfer', 'channel-41'], ['transfer', 'channel-15'], ['transfer', 'channel-11'], ['transfer', 'channel-40']]}

[[chains]]
id = 'crypto-org-chain-mainnet-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.crypto0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.crypto0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.crypto0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'cro'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/crypto/relayer/hermes.minimum-gas-prices" }}, denom = 'basecro' }
max_gas = {{ key "networks/crypto/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# akash, cosmos-hub, emoney, iris, ixo, microtick, persistence, regen, sentinel, starname
packet_filter = { policy = 'allow', list = [['transfer', 'channel-24'], ['transfer', 'channel-27'], ['transfer', 'channel-42'], ['transfer', 'channel-23'], ['transfer', 'channel-41'], ['transfer', 'channel-40'], ['transfer', 'channel-29'], ['transfer', 'channel-25'], ['transfer', 'channel-26'], ['transfer', 'channel-39']]}

[[chains]]
id = 'regen-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.regen0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.regen0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.regen0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'regen'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/regen/relayer/base.minimum-gas-prices" }}, denom = 'uregen' }
max_gas = {{ key "networks/regen/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# akash, cosmos-hub, crypto-org, emoney, iris, ixo, microtick, persistence, sentinel, starname
packet_filter = { policy = 'allow', list = [['transfer', 'channel-10'], ['transfer', 'channel-11'], ['transfer', 'channel-12'], ['transfer', 'channel-35'], ['transfer', 'channel-9'], ['transfer', 'channel-31'], ['transfer', 'channel-30'], ['transfer', 'channel-14'], ['transfer', 'channel-15'], ['transfer', 'channel-29']]}


[[chains]]
id = 'impacthub-3'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.impacthub0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.impacthub0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.impacthub0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'ixo'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/impacthub/relayer/base.minimum-gas-prices" }}, denom = 'uixo' }
max_gas = {{ key "networks/impacthub/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-11']]}

[[chains]]
id = 'juno-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.juno0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.juno0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.juno0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'juno'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/juno/relayer/base.minimum-gas-prices" }}, denom = 'ujuno' }
max_gas = {{ key "networks/juno/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-5']]}

[[chains]]
id = 'emoney-3'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.emoney0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.emoney0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.emoney0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'emoney'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/emoney/relayer/base.minimum-gas-prices" }}, denom = 'ungm' }
max_gas = {{ key "networks/emoney/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '70s'
trusting_period = '10days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-14']]}

{{ end }}

{{ with $ports := key "ports/relay-hub1" | parseJSON }}

[[chains]]
id = 'core-1'
rpc_addr = 'http://{{ env "HOST_IP_2" }}:{{ $ports.core0 }}0'
grpc_addr = 'http://{{ env "HOST_IP_2" }}:{{ $ports.core0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP_2" }}:{{ $ports.core0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'persistence'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/core/relayer/base.minimum-gas-prices" }}, denom = 'uxprt' }
max_gas = {{ key "networks/core/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# akash, cosmos-hub, crypto-org, emoney, iris, ixo, microtick, regen, sentinel, starname
packet_filter = { policy = 'allow', list = [['transfer', 'channel-20'], ['transfer', 'channel-24'], ['transfer', 'channel-23'], ['transfer', 'channel-31'], ['transfer', 'channel-19'], ['transfer', 'channel-30'], ['transfer', 'channel-28'], ['transfer', 'channel-21'], ['transfer', 'channel-22'], ['transfer', 'channel-27']]}

[[chains]]
id = 'iov-mainnet-ibc'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.iov0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.iov0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.iov0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'star'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/iov-mainnet-ibc/relayer/base.minimum-gas-prices" }}, denom = 'uiov' }
max_gas = {{ key "networks/iov-mainnet-ibc/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '10days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-47']]}


{{ end }}