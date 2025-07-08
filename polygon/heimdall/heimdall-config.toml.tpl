# This is a TOML config file for Heimdall service configuration.
# For more information, see https://github.com/toml-lang/toml

##### RPC and REST configs #####

# RPC endpoint for ethereum chain - using Consul service discovery
eth_rpc_url = "{{ range service "eth-execution" }}http://{{ .Address }}:{{ index .ServiceMeta "PortRpc" }}{{ end }}"

# RPC endpoint for bor chain
bor_rpc_url = "http://127.0.0.1:${NOMAD_PORT_bor_rpc}"

# GRPC flag for bor chain
bor_grpc_flag = "false"

# GRPC endpoint for bor chain
bor_grpc_url = "localhost:3131"

# RPC endpoint for tendermint
tendermint_rpc_url = "http://127.0.0.1:${NOMAD_PORT_heimdall_rpc}"

# Polygon Sub Graph URL for self-heal mechanism (optional)
sub_graph_url = ""

#### Bridge configs ####

# Heimdall REST server endpoint, which is used by bridge
heimdall_rest_server = "http://127.0.0.1:${NOMAD_PORT_heimdall_rest}"

# AMQP endpoint
amqp_url = "amqp://guest:guest@localhost:5672/"

## Poll intervals (using defaults for fullnode)
checkpoint_poll_interval = "5m0s"
syncer_poll_interval = "1m0s"
noack_poll_interval = "16m50s"
clerk_poll_interval = "10s"
span_poll_interval = "1m0s"
milestone_poll_interval = "30s"
enable_self_heal = "false"
sh_state_synced_interval = "15m0s"
sh_stake_update_interval = "3h0m0s"
sh_max_depth_duration = "1h0m0s"

#### gas limits ####
main_chain_gas_limit = "5000000"

#### gas price ####
main_chain_max_gas_price = "400000000000"

##### Timeout Config #####
no_ack_wait_time = "30m0s"

##### chain - newSelectionAlgoHeight depends on this #####
chain = "mainnet"
