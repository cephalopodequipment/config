{{ with secret "static_secrets/ankr" }}
# [required] replace with your preferred L1 (Ethereum, not Unichain) node RPC URL:
OP_NODE_L1_ETH_RPC={{ .Data.data.eth_mainnet }}
# [required] replace with your preferred L1 CL beacon endpoint:
OP_NODE_L1_BEACON={{ .Data.data.eth_mainnet_beacon }}
{{ end }}
