# Heimdall Service Configuration
# This file configures Heimdall's connections to external services

# Ethereum RPC connection
eth_rpc_url = "{{ range service "eth-full-node0.eth-execution" }}http://{{ .Address }}:{{ index .ServiceMeta "PortRpc" }}{{ end }}"

# Bor RPC connection - use host network since we're in host mode
bor_rpc_url = "http://{{ env "attr.unique.network.ip-address" }}:{{ env "NOMAD_PORT_bor_rpc" }}" 