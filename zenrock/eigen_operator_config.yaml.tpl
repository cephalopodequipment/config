register_operator_on_startup: true
register_on_startup: true
production: true
#To be manually updated
operator_address: 0x48C1bCB66A376e934BC16dcb0477833a4abD16f2
operator_validator_address: zenvaloper1hpf9q9u4g0qmnl4qcumxcu0g8uqtmvg0hw287a

# EigenLayer Slasher contract address
# This is the address of the contracts which are deployed in the anvil saved state
# The saved eigenlayer state is located in tests/anvil/credible_squaring_avs_deployment_output.json
avs_registry_coordinator_address: 0xdc3A1b2a44D18c6B98a1d6c8C042247d2F5AC722
operator_state_retriever_address: 0xdB55356826a16DfFBD86ba334b84fC4E37113d97

# ETH RPC URL
eth_rpc_url: https://holesky.infura.io/v3/c21b9a2253ea41abb0c4205e23e92706
eth_ws_url: wss://holesky.infura.io/ws/v3/c21b9a2253ea41abb0c4205e23e92706

# ECDSA key
ecdsa_private_key_store_path: /home/zenrock/.zrchain/sidecar/keys/ecdsa.key.json

# We are using bn254 curve for bls keys
bls_private_key_store_path: /home/zenrock/.zrchain/sidecar/keys/bls.key.json

# address which the aggregator listens on for operator signed messages
aggregator_server_ip_port_address: avs-aggregator.gardia.zenrocklabs.io:8090

# avs node spec compliance https://eigen.nethermind.io/docs/spec/intro
eigen_metrics_ip_port_address: 0.0.0.0:9292
enable_metrics: true
metrics_address: 0.0.0.0:9292
node_api_ip_port_address: 0.0.0.0:9191
enable_node_api: true

# address of token to deposit tokens into when registering on startup
token_strategy_addr: 0x80528D6e9A2BAbFc766965E0E26d5aB08D9CFaF9
service_manager_address: 0xa559CDb9e029fc4078170122eBf7A3e622a764E4
zr_chain_rpc_address: localhost:9790