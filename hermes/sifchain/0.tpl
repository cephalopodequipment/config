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
tx_confirmation = true

[rest]
enabled = true
host = '0.0.0.0'
port = {{ env "NOMAD_PORT_rest" }}

[telemetry]
enabled = true
host = '0.0.0.0'
port = {{ env "NOMAD_PORT_prom" }}

{{ with $ports := key "ports/prod1" | parseJSON }}

[[chains]]
id = 'core-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.core_relayer0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.core_relayer0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.core_relayer0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'persistence'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/core/hermes.gas_price" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uxprt' }
max_gas = {{ key "networks/core/hermes.max_gas" }}
max_msg_num = 15
gas_multiplier = 1.1
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-26']]}


[[chains]]
id = 'sentinelhub-2'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.sentinelhub_relayer0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.sentinelhub_relayer0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.sentinelhub_relayer0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'sent'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/sentinelhub/hermes.gas_price" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'udvpn' }
max_gas = {{ key "networks/sentinelhub/hermes.max_gas" }}
max_msg_num = 15
gas_multiplier = 1.1
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-36']]}


[[chains]]
id = 'impacthub-3'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.impacthub_relayer0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.impacthub_relayer0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.impacthub_relayer0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'ixo'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/impacthub/hermes.gas_price" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uixo' }
max_gas = {{ key "networks/impacthub/hermes.max_gas" }}
max_msg_num = 15
gas_multiplier = 1.1
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-11']]}


[[chains]]
id = 'crypto-org-chain-mainnet-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.crypto_relayer0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.crypto_relayer0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.crypto_relayer0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'cro'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/crypto/hermes.gas_price" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'basecro' }
max_gas = {{ key "networks/crypto/hermes.max_gas" }}
max_msg_num = 15
gas_multiplier = 1.1
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-33']]}


[[chains]]
id = 'columbus-5'
rpc_addr = 'http://10.10.51.65:26600'
grpc_addr = 'http://10.10.51.65:26602'
websocket_addr = 'ws://10.10.51.65:26600/websocket'
rpc_timeout = '20s'
account_prefix = 'terra'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/terra/hermes.gas_price" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'usek' }
max_gas = {{ key "networks/terra/hermes.max_gas" }}
max_msg_num = 50
gas_multiplier = 1.1
max_tx_size = 650000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-7']]}


[[chains]]
id='akashnet-2'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.akashnet_relayer0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.akashnet_relayer0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.akashnet_relayer0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'akash'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/akashnet/hermes.gas_price" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uakt' }
max_gas = {{ key "networks/akashnet/hermes.max_gas" }}
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-24']]}


[[chains]]
id = 'juno-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.juno_relayer1 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.juno_relayer1 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.juno_relayer1 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'juno'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/juno/hermes.gas_price" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'ujuno' }
max_gas = {{ key "networks/juno/hermes.max_gas" }}
max_msg_num = 15
gas_multiplier = 1.1
max_tx_size = 450000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-5']]}


[[chains]]
id = 'regen-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.regen_relayer0 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.regen_relayer0 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.regen_relayer0 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'regen'
key_name = 'aw4'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/regen/hermes.gas_price" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'uregen' }
max_gas = {{ key "networks/regen/hermes.max_gas" }}
max_msg_num = 15
gas_multiplier = 1.1
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
packet_filter = { policy = 'allow', list = [['transfer', 'channel-28']]}


[[chains]]
id = 'sifchain-1'
rpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.sifchain_relayer1 }}0'
grpc_addr = 'http://{{ env "HOST_IP" }}:{{ $ports.sifchain_relayer1 }}2'
websocket_addr = 'ws://{{ env "HOST_IP" }}:{{ $ports.sifchain_relayer1 }}0/websocket'
rpc_timeout = '8s'
account_prefix = 'sif'
key_name = 'aw3'
store_prefix = 'ibc'
memo_prefix = 'Connect the Interchain. Stake with Cephalopod 🐙'
gas_price = { price = {{ key "networks/sifchain/hermes.gas_price" | regexReplaceAll "[A-Za-z]*" "" | replaceAll "\"" "" }}, denom = 'rowan' }
max_gas = {{ key "networks/sifchain/hermes.max_gas" }}
max_msg_num = 15
gas_multiplier = 1.1
max_tx_size = 180000
clock_drift = '7200s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
# sentinelhub
# akashnet
# core
# irishub
# crypto
# regen
# juno
# impacthub
# columbus
packet_filter = { policy = 'allow', list = [['transfer', 'channel-1'],
                                            ['transfer', 'channel-2'],
                                            ['transfer', 'channel-7'],
                                            ['transfer', 'channel-9'],
                                            ['transfer', 'channel-10'],
                                            ['transfer', 'channel-14'],
                                            ['transfer', 'channel-15'],
                                            ['transfer', 'channel-18']]}

{{ end }}