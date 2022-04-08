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
port = {{ $ports.hermes_crescent0 }}

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
max_msg_num = 50
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# akash
# crypto-org
# emoney
# iris
# juno
# regen
# sentinel
packet_filter = { policy = 'allow', list = [['transfer', 'channel-184'],
                                            ['transfer', 'channel-187'],
                                            ['transfer', 'channel-202'],
                                            ['transfer', 'channel-182'],
                                            ['transfer', 'channel-207'],
                                            ['transfer', 'channel-186'],
                                            ['transfer', 'channel-185']]}

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
max_msg_num = 30
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer','channel-17']]}


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
max_msg_num = 30
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer','channel-27']]}


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
gas_price = { price = {{ key "networks/emoney/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'ungm' }
max_gas = {{ key "networks/emoney/relayer/hermes.max-gas" }}
max_msg_num = 30
max_tx_size = 180000
clock_drift = '70s'
trusting_period = '10days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer','channel-1']]}


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
max_msg_num = 30
max_tx_size = 1800000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer','channel-12']]}


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
gas_price = { price = {{ key "networks/juno/relayer/base.minimum-gas-prices" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'ujuno' }
max_gas = {{ key "networks/juno/relayer/hermes.max-gas" }}
max_msg_num = 30
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-1']]}


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
max_msg_num = 30
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer','channel-12']]}


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
max_msg_num = 30
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer','channel-11']]}

{{ end }}