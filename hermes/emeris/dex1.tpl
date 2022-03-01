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
gas_price = { price = {{ key "networks/cosmoshub/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uatom' }
max_gas = {{ key "networks/cosmoshub/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# akash, sentinelhub, crypto-org, regen, irishub
packet_filter = { policy = 'allow', list = [['transfer','channel-184'],['transfer','channel-186'],['transfer','channel-187'],['transfer','channel-185'],['transfer','channel-182']]}

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
gas_price = { price = {{ key "networks/akashnet/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uakt' }
max_gas = {{ key "networks/akashnet/relayer/hermes.max-gas" }}
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# cosmoshub, sentinelhub, crypto-org, regen, irishub
packet_filter = { policy = 'allow', list = [['transfer','channel-17'],['transfer','channel-22'],['transfer','channel-18'],['transfer','channel-21'],['transfer','channel-16']]}

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
gas_price = { price = {{ key "networks/sentinelhub/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'udvpn' }
max_gas = {{ key "networks/sentinelhub/relayer/hermes.max-gas" }}
max_msg_num = 15
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# cosmoshub, akashnet, crypto-org, regen, irishub
packet_filter = { policy = 'allow', list = [['transfer','channel-12'],['transfer','channel-10'],['transfer','channel-13'],['transfer','channel-11'],['transfer','channel-9']]}

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
gas_price = { price = {{ key "networks/crypto/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'basecro' }
max_gas = {{ key "networks/crypto/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# cosmoshub, akashnet, sentinelhub, regen, irishub
packet_filter = { policy = 'allow', list = [['transfer','channel-27'],['transfer','channel-24'],['transfer','channel-26'],['transfer','channel-25'],['transfer','channel-23']]}

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
gas_price = { price = {{ key "networks/regen/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uregen' }
max_gas = {{ key "networks/regen/relayer/hermes.max-gas" }}
max_msg_num = 15
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# cosmoshub, akashnet, sentinelhub, crypto-org, irishub
packet_filter = { policy = 'allow', list = [['transfer','channel-11'],['transfer','channel-10'],['transfer','channel-15'],['transfer','channel-12'],['transfer','channel-9']]}

[[chains]]
id = 'irishub-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.irishub0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.irishub0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.irishub0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'iaa'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/irishub/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uiris' }
max_gas = {{ key "networks/irishub/relayer/hermes.max-gas" }}
max_msg_num=15
max_tx_size = 1800000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# cosmoshub, akashnet, sentinelhub, crypto-org, regen
packet_filter = { policy = 'allow', list = [['transfer','channel-12'],['transfer','channel-11'],['transfer','channel-17'],['transfer','channel-12'],['transfer','channel-16']]}

{{ end }}