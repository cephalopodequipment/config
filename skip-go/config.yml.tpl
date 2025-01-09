# IMPORTANT: Replace all values within <angle_brackets> with your specific configuration details.
# Do NOT leave any angle brackets in the final configuration.
metrics:
  prometheus_address: "0.0.0.0:8001"

coingecko:
  base_url: "https://pro-api.coingecko.com/api/v3/"
  # API key is optional here. If you do not have an API key, you can remove the
  # api_key option all together. If you have a coin gecko API key, we will use
  # it to get more up to date gas costs. If you specify an API key, you should
  # reduce the requests per minute and cache refresh interval according to your
  # keys limits. The values are currently set for no API key use.
  api_key: <api_key>
  requests_per_minute: 2
  cache_refresh_interval: "15m"

order_filler:
  worker_count: 10

transfer_monitor:
  poll_interval: 5s


{{ if (key "networks/skip-go/rebalance.enable" | parseBool)}}
# The fund_rebalancer config is optional. If you do not want the solver to
# rebalance your funds across chains via Skip GO (via the CCTP slow path CCTP, they
# will not be fast transferred via Skip Go Fast), you can omit the
# fund_rebalancer config all together.
fund_rebalancer:
{{- range $network, $job_config := (key "networks/skip-go/chain_config" | parseJSON) -}}
{{- if eq $network "ethereum" }}
{{ key "networks/skip-go/rebalance.eth" }}
{{- end -}}
{{ if eq $network "arbitrum"}}
{{ key "networks/skip-go/rebalance.arbitrum" }}
{{- end -}}
{{ if eq $network "avalanche"}}
{{ key "networks/skip-go/rebalance.avalanche" }}
{{- end -}}
{{ if eq $network "polygon"}}
{{ key "networks/skip-go/rebalance.polygon" }}
{{- end -}}
{{ if eq $network "base"}}
{{ key "networks/skip-go/rebalance.base" }}
{{- end -}}
{{ if eq $network "optimism"}}
{{ key "networks/skip-go/rebalance.optimism" }}
{{- end -}}
{{ if eq $network "osmosis"}}
{{ key "networks/skip-go/rebalance.osmosis" }}
{{- end -}}
{{- end }}
{{- end }}

chains:
{{- range $network, $job_config := (key "networks/skip-go/chain_config" | parseJSON) -}}
{{- if eq $network "ethereum" }}
  1:
    chain_name: "ethereum"
    chain_id: "1"
    type: "evm"
    environment: "mainnet"
    gas_token_symbol: "ETH"
    gas_token_decimals: 18
    gas_token_coingecko_id: "ethereum"
    hyperlane_domain: "1"
    fast_transfer_contract_address: "0xe7935104c9670015b21c6300e5b95d2f75474cda"
    quick_start_num_blocks_back: {{ $job_config.quick_start_num_blocks_back }}
    num_block_confirmations_before_fill: {{ $job_config.num_block_confirmations_before_fill }} # e.g. 1
    max_rebalancing_gas_cost_uusdc: "{{ $job_config.max_rebalancing_gas_cost_uusdc }}"
    solver_address: {{ $job_config.solver_address }}
    usdc_denom: "0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48"
    min_fee_bps: {{ $job_config.min_fee_bps }}
    batch_uusdc_settle_up_threshold: {{ $job_config.batch_uusdc_settle_up_threshold }} # 1/2 of destination inventory evenly distributed across source chains
    min_profit_margin_bps: {{ $job_config.min_profit_margin_bps }} #MUST BE GREATER THAN min_fee_bps
    evm:
      rpc: {{ with secret "static_secrets/skip-go"}}{{ .Data.data.eth_rpc }}{{ end }}
      signer_gas_balance:
        warning_threshold_wei: {{ $job_config.warning_threshold_wei }}
        critical_threshold_wei: {{ $job_config.critical_threshold_wei }}
    relayer:
      mailbox_address: "0xc005dc82818d67AF737725bD4bf75435d065D239"
      profitable_relay_timeout: {{ $job_config.profitable_relay_timeout }}
      relay_cost_cap_uusdc: {{ $job_config.relay_cost_cap_uusdc }}
{{- end -}}
{{ if eq $network "optimism" }}
  10:
    chain_name: "optimism"
    chain_id: "10"
    type: "evm"
    environment: "mainnet"
    gas_token_symbol: "ETH"
    gas_token_decimals: 18
    gas_token_coingecko_id: "ethereum"
    hyperlane_domain: "10"
    fast_transfer_contract_address: "0x0f479de4fd3144642f1af88e3797b1821724f703"
    quick_start_num_blocks_back: {{ $job_config.quick_start_num_blocks_back }}
    num_block_confirmations_before_fill: {{ $job_config.num_block_confirmations_before_fill }} # e.g. 1
    max_rebalancing_gas_cost_uusdc: "{{ $job_config.max_rebalancing_gas_cost_uusdc }}"
    solver_address: {{ $job_config.solver_address }}
    usdc_denom: "0x0b2c639c533813f4aa9d7837caf62653d097ff85"
    min_fee_bps: {{ $job_config.min_fee_bps }}
    batch_uusdc_settle_up_threshold: {{ $job_config.batch_uusdc_settle_up_threshold }} # 1/2 of destination inventory evenly distributed across source chains
    min_profit_margin_bps: {{ $job_config.min_profit_margin_bps }} #MUST BE GREATER THAN min_fee_bps
    evm:
      rpc: {{ with secret "static_secrets/skip-go"}}{{ .Data.data.optimism_rpc }}{{ end }}
      signer_gas_balance:
        warning_threshold_wei: {{ $job_config.warning_threshold_wei }}
        critical_threshold_wei: {{ $job_config.critical_threshold_wei }}
    relayer:
      mailbox_address: "0xd4C1905BB1D26BC93DAC913e13CaCC278CdCC80D"
      profitable_relay_timeout: {{ $job_config.profitable_relay_timeout }}
      relay_cost_cap_uusdc: {{ $job_config.relay_cost_cap_uusdc }}
{{- end -}}
{{ if eq $network "arbitrum" }}
  42161:
    chain_name: "arbitrum"
    chain_id: "42161"
    type: evm
    environment: "mainnet"
    gas_token_symbol: "ETH"
    gas_token_decimals: 18
    gas_token_coingecko_id: "ethereum"
    fast_transfer_contract_address: "0x23cb6147e5600c23d1fb5543916d3d5457c9b54c"
    solver_address: {{ $job_config.solver_address }}
    usdc_denom: "0xaf88d065e77c8cC2239327C5EDb3A432268e5831"
    hyperlane_domain: "42161"
    quick_start_num_blocks_back: {{ $job_config.quick_start_num_blocks_back }}
    num_block_confirmations_before_fill: {{ $job_config.num_block_confirmations_before_fill }} # e.g. 1
    min_fee_bps: {{ $job_config.num_block_confirmations_before_fill }}
    batch_uusdc_settle_up_threshold: {{ $job_config.batch_uusdc_settle_up_threshold }} # 1/2 of destination inventory evenly distributed across source chains
    min_profit_margin_bps: {{ $job_config.min_profit_margin_bps }}
    evm:
      rpc: {{ with secret "static_secrets/skip-go"}}{{ .Data.data.arbitrum_rpc }}{{ end }}
      rpc_basic_auth_var: <env_var_with_server_password>
      signer_gas_balance:
        warning_threshold_wei: {{ $job_config.warning_threshold_wei }}
        critical_threshold_wei: {{ $job_config.critical_threshold_wei }}
    relayer:
      mailbox_address: "0x979Ca5202784112f4738403dBec5D0F3B9daabB9"
      profitable_relay_timeout: {{ $job_config.profitable_relay_timeout }}
      relay_cost_cap_uusdc: {{ $job_config.relay_cost_cap_uusdc }}
{{- end -}}
{{ if eq $network "osmosis" }}
  osmosis-1:
    chain_name: "osmosis"
    chain_id: "osmosis-1"
    type: "cosmos"
    environment: "mainnet"
    gas_token_symbol: "OSMO"
    gas_token_decimals: 6
    gas_token_coingecko_id: "osmosis"
    quick_start_num_blocks_back: {{ $job_config.quick_start_num_blocks_back }}
    num_block_confirmations_before_fill: {{ $job_config.num_block_confirmations_before_fill }} # e.g. 1
    fast_transfer_contract_address: osmo1vy34lpt5zlj797w7zqdta3qfq834kapx88qtgudy7jgljztj567s73ny82
    solver_address: {{ $job_config.solver_address }}
    hyperlane_domain: "875"
    usdc_denom: "ibc/498A0751C798A0D9A389AA3691123DADA57DAA4FE165D5C75894505B876BA6E4"
    cosmos:
      address_prefix: "osmo"
      rpc: {{ range service (printf "osmosis.%s.cometbft-rpc" $job_config.node_id) -}}http://{{.Address}}:{{ .Port }}{{- end }}
      grpc: {{ range service (printf "osmosis.%s.cosmos-sdk-grpc" $job_config.node_id) -}}http://{{.Address}}:{{ .Port }}{{- end }}
      grpc_tls_enabled: false # e.g. false
      min_fill_size: {{ $job_config.min_fill_size }}
      max_fill_size: {{ $job_config.max_fill_size }}
      signer_gas_balance:
        warning_threshold_wei: {{ $job_config.warning_threshold_wei }} # 100 osmo ~ $50
        critical_threshold_wei: {{ $job_config.critical_threshold_wei }} # 40 osmo ~ $20
      gas_price: 0.0025
      gas_denom: "uosmo"
    relayer:
      validator_announce_contract_address: "osmo147r8mfdsngswujgkr4tln9rhcrzz6yq0xn448ksd96mlcmp9wg6stvznke"
      merkle_hook_contract_address: "osmo1e765uc5mctl7rz8dzl9decl5ghgxggeqyxutkjp2xkggrg6zma3qgdq2g4"
      mailbox_address: "osmo1r6u37zv47ke4d2k9tkzun72ch466w6594kv8gqgrtmsvf7qxpm9sj95v98"
      profitable_relay_timeout: {{ $job_config.profitable_relay_timeout }}
      relay_cost_cap_uusdc: {{ $job_config.relay_cost_cap_uusdc }}
{{- end -}}
{{ if eq $network "base" }}
  8453:
    chain_name: "base"
    chain_id: "8453"
    type: "evm"
    environment: "mainnet"
    gas_token_symbol: "ETH"
    gas_token_decimals: 18
    gas_token_coingecko_id: "ethereum"
    hyperlane_domain: "8453"
    fast_transfer_contract_address: "0x43d090025aaa6c8693b71952b910ac55ccb56bbb"
    quick_start_num_blocks_back: {{ $job_config.quick_start_num_blocks_back }}
    num_block_confirmations_before_fill: {{ $job_config.num_block_confirmations_before_fill }} # e.g. 1
    max_rebalancing_gas_cost_uusdc: "{{ $job_config.max_rebalancing_gas_cost_uusdc }}"
    solver_address: {{ $job_config.solver_address }}
    usdc_denom: "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913"
    min_fee_bps: {{ $job_config.min_fee_bps }}
    batch_uusdc_settle_up_threshold: {{ $job_config.batch_uusdc_settle_up_threshold }} # 1/2 of destination inventory evenly distributed across source chains
    min_profit_margin_bps: {{ $job_config.min_profit_margin_bps }} #MUST BE GREATER THAN min_fee_bps
    evm:
      rpc: {{ with secret "static_secrets/skip-go"}}{{ .Data.data.base_rpc }}{{ end }}
      signer_gas_balance:
        warning_threshold_wei: {{ $job_config.warning_threshold_wei }}
        critical_threshold_wei: {{ $job_config.critical_threshold_wei }}
    relayer:
      mailbox_address: "0xeA87ae93Fa0019a82A727bfd3eBd1cFCa8f64f1D"
      profitable_relay_timeout: {{ $job_config.profitable_relay_timeout }}
      relay_cost_cap_uusdc: {{ $job_config.relay_cost_cap_uusdc }}
{{- end -}}
{{- end }}
