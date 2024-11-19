{{ with secret "static_secrets/ankr" -}}
register_operator_on_startup: true
register_on_startup: true
production: true
#To be manually updated
operator_address: {{ keyOrDefault  (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/eigen.operator") "" }}
operator_validator_address: {{ keyOrDefault  (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/eigen.validator") "" }}

# EigenLayer Slasher contract address
# This is the address of the contracts which are deployed in the anvil saved state
# The saved eigenlayer state is located in tests/anvil/credible_squaring_avs_deployment_output.json
avs_registry_coordinator_address: 0xFbB0cbF0d14C8BaE1f36Cd4Dff792ca412b72Af0
operator_state_retriever_address: 0xe7FDe0EFCECBbcC25F326EdC80E6B79c1482dAaB

# ETH RPC URL
eth_rpc_url: {{ .Data.data.holesky_endpoint }}
eth_ws_url: {{ .Data.data.holesky_ws_endpoint }}
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
service_manager_address: 0x3AD648DfE0a6D80745ab2Ec97CB67c56bfBEc032
zr_chain_rpc_address: localhost:9790
{{- end -}}