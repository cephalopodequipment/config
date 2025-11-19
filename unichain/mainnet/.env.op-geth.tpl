# Core op-geth Configuration
# Base settings for the op-geth node, including network and rollup integration.

# Target network (e.g., Unichain Sepolia testnet).
GETH_OP_NETWORK=unichain-mainnet

# Rollup sequencer HTTP endpoint for transaction submission.
GETH_ROLLUP_SEQUENCERHTTP=https://mainnet-sequencer.unichain.org

# Logging & Verbosity
# Configure logging format and verbosity level for debugging and monitoring.
GETH_LOG_FORMAT=logfmt
# Verbosity level (0-6) for detailed logging output.
GETH_VERBOSITY=3

# Data Directory & RPC Settings
# Define the data directory and enable HTTP/WS endpoints for external interaction.
GETH_DATADIR=/data
# HTTP endpoint for JSON-RPC requests (e.g., `eth_getBlockByNumber`).
GETH_HTTP=true
GETH_HTTP_ADDR=0.0.0.0
GETH_HTTP_PORT={{ env "NOMAD_PORT_ex_rpc" }}

# Enabled JSON-RPC APIs for HTTP endpoint.
GETH_HTTP_API=web3,debug,eth,txpool,net,admin,rpc

# WebSocket endpoint for real-time data streaming.
GETH_WS=true
GETH_WS_ADDR=0.0.0.0
GETH_WS_PORT={{ env "NOMAD_PORT_ex_ws" }}

# Enabled WebSocket APIs for WebSocket endpoint.
GETH_WS_API=web3,debug,eth,txpool,net,admin,rpc

# Authentication & Security
# JWT authentication for secure access to the node's API.
GETH_AUTHRPC_JWTSECRET=/shared/jwt.hex
GETH_AUTHRPC_PORT={{ env "NOMAD_PORT_ex_authrpc" }}
GETH_AUTHRPC_ADDR=0.0.0.0

# Metrics & Monitoring
# Enable metrics collection for performance and health monitoring using Prometheus or other monitoring tools.
GETH_METRICS=true
GETH_METRICS_ADDR=0.0.0.0
GETH_METRICS_PORT={{ env "NOMAD_PORT_ex_prom" }}

# P2P & Sync Configuration
# Configure peer discovery, gossip, and sync behavior for network communication.
GETH_ROLLUP_DISABLETXPOOLGOSSIP=true

# Prevent local transactions from being broadcasted to the network.
GETH_TXPOOL_NOLOCALS=true

# Bootnodes for initial peer discovery in the P2P network.
GETH_BOOTNODES={{ key (print (env "OP_GETH_CONSUL_PATH") "/op-geth.bootnodes") }}
