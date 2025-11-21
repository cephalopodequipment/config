# Core op-node Configuration
# Default setup for the Optimism node, including L1 RPC and beacon endpoints. These are required for the node to connect to the Ethereum L1 network.

{{ with secret "static_secrets/ankr" }}
# [required] replace with your preferred L1 (Ethereum, not Unichain) node RPC URL:
OP_NODE_L1_ETH_RPC={{ .Data.data.eth_mainnet }}
# [required] replace with your preferred L1 CL beacon endpoint:
OP_NODE_L1_BEACON={{ .Data.data.eth_mainnet_beacon }}
{{ end }}

# Define the target network (e.g., Unichain Sepolia testnet).
OP_NODE_NETWORK=unichain-mainnet

# JWT authentication path for L2 engine communication.
OP_NODE_L2_ENGINE_AUTH=/shared/jwt.hex

# L2 engine RPC endpoint for communication with the execution layer.
#OP_NODE_L2_ENGINE_RPC={{ env "NOMAD_IP_ex_rpc" }}:{{ env "NOMAD_PORT_ex_rpc" }}

# Logging & Metrics
# Configure logging format and enable metrics for monitoring. Metrics are exposed on the specified port for external tools.
OP_NODE_LOG_LEVEL=info
OP_NODE_LOG_FORMAT=logfmt
OP_NODE_METRICS_ADDR=0.0.0.0
OP_NODE_METRICS_ENABLED=true
OP_NODE_METRICS_PORT={{ env "NOMAD_PORT_op_prom" }}

# P2P Network Settings
# P2P peer discovery, storage, and NAT traversal configuration. Enables node-to-node communication.
OP_NODE_P2P_LISTEN_IP=0.0.0.0
OP_NODE_P2P_LISTEN_TCP_PORT={{ env "NOMAD_HOST_PORT_op_p2p" }}
OP_NODE_P2P_LISTEN_UDP_PORT={{ env "NOMAD_HOST_PORT_op_p2p" }}
OP_NODE_RPC_ADDR=0.0.0.0
OP_NODE_RPC_PORT={{ env "NOMAD_PORT_op_rpc" }}

# Number of L1 confirmations required for validator operations.
OP_NODE_VERIFIER_L1_CONFS=4

# Enable NAT traversal for peer discovery in private networks.
OP_NODE_P2P_NAT=true

# Path to store peer discovery data.
OP_NODE_P2P_DISCOVERY_PATH=/data/opnode_discovery_db

# Path to store peer information for network communication.
OP_NODE_P2P_PEERSTORE_PATH=/data/opnode_peerstore_db

# Path to store private peer keys.
OP_NODE_P2P_PRIV_PATH=/data/opnode_p2p_priv.txt

# Bootnodes for initial peer discovery in the P2P network.
OP_NODE_P2P_BOOTNODES={{ key (print (env "OP_NODE_CONSUL_PATH") "/p2p.bootnodes") }}

# Execution Layer Sync
# op-node can drive the Execution Client to sync from the EL layer. This enables Snap Sync in op-geth or staged sync in op-reth.
# This requires the EL Client to be peered. By default, OP geth uses snap sync, but can use full sync while OP_NODE_SYNCMODE=execution-layer.
OP_NODE_SYNCMODE=execution-layer