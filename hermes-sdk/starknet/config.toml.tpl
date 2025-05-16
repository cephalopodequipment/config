{{ range $chain_id, $job_config  := (key (printf "hermes-sdk/relayers/%s/starknet_chain_config" (env "JOB_NAME")) | parseJSON) }}
{{ $chain_config := tree (printf "hermes-sdk/networks/%s" $chain_id) | explode }}

[starknet_chain_config]
poll_interval = "{{or $chain_config.poll_interval "40s" }}"
block_time    = { secs = {{or $chain_config.block_time_secs 30 }}, nanos = {{or $chain_config.block_time_nanos 0 }} }

{{ if $job_config.use_public_rpc }}
json_rpc_url = "{{ $job_config.public_rpc }}"
{{ else }}
json_rpc_url = "{{ range service "starknet-testnet-rpc" }}http://{{ .Address }}:{{ .Port }}{{ end }}"
{{ end }}

relayer_wallet = "{{ env "HERMES_SDK_STARKNET_WALLET_FILE_PATH" }}"

[starknet_chain_config.contract_classes]
erc20      = "{{ env "ERC20_CONTRACT_CLASS" }}"
ics20      = "{{ env "ICS20_CONTRACT_CLASS" }}"
ibc_client = "{{ env "IBC_CLIENT_CONTRACT_CLASS" }}"

[starknet_chain_config.contract_addresses]
ibc_client = "{{ env "IBC_CLIENT_CONTRACT_ADDRESS" }}"
ibc_core   = "{{ env "IBC_CORE_CONTRACT_ADDRESS" }}"
ibc_ics20 = "{{ env "IBC_ICS20_CONTRACT_ADDRESS" }}"

{{- end -}}

{{ range $chain_id, $job_config  := (key (printf "hermes-sdk/relayers/%s/cosmos_chain_config" (env "JOB_NAME")) | parseJSON) }}
{{ $chain_config := tree (printf "hermes-sdk/networks/%s" $chain_id) | explode }}

[cosmos_chain_config]
id             = '{{ $chain_id }}'
account_prefix = '{{ $chain_config.account_prefix }}'
store_prefix   = 'ibc'
rpc_timeout    = { secs = 6, nanos = 0 }
address_type   = 'cosmos'
max_msg_num    = {{or $chain_config.max_msg_num 4 }}
max_tx_size    = {{or $chain_config.max_tx_size 1048576 }}

{{ if $job_config.use_public_rpc }}
rpc_addr     = "{{ $job_config.public_rpc }}"
grpc_addr    = "{{ $job_config.public_grpc }}"
event_source = { mode = 'push', url = "{{ $job_config.public_rpc }}" }
{{ else }}
rpc_addr     = '{{ range service (printf "%s.cometbft-rpc" $job_config.consul_service) }}http://{{ .Address }}:{{ .Port }}{{ end }}'
grpc_addr    = '{{ range service (printf "%s.cosmos-sdk-grpc" $job_config.consul_service) }}http://{{ .Address }}:{{ .Port }}{{ end }}'
event_source = { mode = 'push', url = '{{ range service (printf "%s.cometbft-rpc" $job_config.consul_service) }}ws://{{ .Address }}:{{ .Port }}{{ end }}' }
{{ end }}

# hermes-v1 key should be present at `<key_store_folder>/<key_name>.json`
key_store_folder = "{{ env "HERMES_SDK_WALLET_PATH" }}"
key_name         = '{{ $job_config.key_name }}'

block_time        = { secs = 0, nanos = 520000000 }
clock_drift       = { secs = 1, nanos = 0 }
max_block_time    = { secs = 10, nanos = 0 }
compat_mode       = "{{or $chain_config.compat_mode "v0.37"}}"
extension_options = [  ]
poll_interval     = { secs = 1, nanos = 0 }

[cosmos_chain_config.gas_config]
default_gas        = {{ $chain_config.default_gas }}
max_gas            = {{ $chain_config.max_gas }}
gas_multiplier     = {{ $chain_config.gas_multiplier }}
gas_price          = {{ $chain_config.gas_price }}
fee_granter        = ''
{{ if $chain_config.dynamic_gas_enabled }}
dynamic_gas_config = { multiplier = {{ $chain_config.dynamic_gas_multiplier }}, max = {{ $chain_config.dynamic_max_gas_price }}, eip_query_type = "{{or $chain_config.dynamic_gas_eip_query_type "Osmosis" }}", denom = "{{or $chain_config.dynamic_gas_denom "uosmo" }}" }
{{ end }}

[cosmos_chain_config.gas_config.max_fee]
amount    = [ { amount = "{{ $chain_config.max_fee }}", denom = '{{ $chain_config.max_fee_denom }}' } ]
gas_limit = {{ $chain_config.max_fee_gas_limit }}
payer     = ''
granter   = ''

{{ end }}

