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
clear_interval = 89
clear_on_start = true
tx_confirmation = false

{{ with $ports := key "ports/relay-hub0" | parseJSON }}

[rest]
enabled = true
host = '0.0.0.0'
port = {{ $ports.hermes_sifchain }}

[[chains]]
id = 'cosmoshub-4'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.cosmoshub0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.cosmoshub0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.cosmoshub0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'cosmos'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/cosmoshub/relayer/base.minimum-gas-prices" }}, denom = 'uatom' }
max_gas = {{ key "networks/cosmoshub/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-192']]}

[[chains]]
id='akashnet-2'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.akashnet0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.akashnet0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.akashnet0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'akash'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/akashnet/relayer/base.minimum-gas-prices" }}, denom = 'uakt' }
max_gas = {{ key "networks/akashnet/relayer/hermes.max-gas" }}
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-24']]}

[[chains]]
id = 'sentinelhub-2'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.sentinelhub0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.sentinelhub0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.sentinelhub0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'sent'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/sentinelhub/relayer/base.minimum-gas-prices" }}, denom = 'udvpn' }
max_gas = {{ key "networks/sentinelhub/relayer/hermes.max-gas" }}
max_msg_num = 15
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-36']]}

[[chains]]
id = 'crypto-org-chain-mainnet-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.crypto0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.crypto0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.crypto0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'cro'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/crypto/relayer/base.minimum-gas-prices" }}, denom = 'basecro' }
max_gas = {{ key "networks/crypto/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-33']]}

[[chains]]
id = 'regen-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.regen0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.regen0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.regen0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'regen'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/regen/relayer/base.minimum-gas-prices" }}, denom = 'uregen' }
max_gas = {{ key "networks/regen/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-28']]}

[[chains]]
id = 'irishub-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.irishub0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.irishub0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.irishub0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'iaa'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/irishub/relayer/base.minimum-gas-prices" }}, denom = 'uiris' }
max_gas = {{ key "networks/irishub/relayer/hermes.max-gas" }}
max_msg_num=15
max_tx_size = 1800000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-19']]}

[[chains]]
id = 'impacthub-3'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.impacthub0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.impacthub0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.impacthub0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'ixo'
key_name = 'aw4'
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
key_name = 'aw4'
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
key_name = 'aw4'
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

[[chains]]
id = 'osmosis-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.osmosis0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.osmosis0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.osmosis0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'osmo'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/osmosis/relayer/base.minimum-gas-prices" }}, denom = 'uosmo' }
max_gas = {{ key "networks/osmosis/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '10days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-47']]}

[[chains]]
id = 'sifchain-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.sifchain0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.sifchain0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.sifchain0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'sif'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/sifchain/relayer/base.minimum-gas-prices" }}, denom = 'rowan' }
max_gas = {{ key "networks/sifchain/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# cosmoshub, akash, crypto-org, iris, regen, sentinel, regen, osmosis, juno, ixo, emoney
packet_filter = { policy = 'allow', list = [['transfer', 'channel-0'], ['transfer', 'channel-2'], ['transfer', 'channel-9'], ['transfer', 'channel-8'], ['transfer', 'channel-1'], ['transfer', 'channel-10'], ['transfer', 'channel-17'], ['transfer', 'channel-13'], ['transfer', 'channel-14'], ['transfer', 'channel-15'], ['transfer', 'channel-19']]

{{ end }}
