# Polygon Bor Configuration File
# This file contains configuration options for the Polygon Bor client

# Identity of the node
identity = "{{ keyOrDefault "networks/polygon/bor/identity" "polygon-full-node0" }}"

# The data directory for the node
datadir = "/bor-home"

# Port to listen for incoming P2P connections
port = {{ env "BOR_P2P_PORT" }}

# Sync mode for the node
# Options: "full", "fast", "light", "snap"
syncmode = "full"

# Garbage collection mode
# Options: "full", "archive"
gcmode = "full"

# Chain ID for the network (137 for Polygon mainnet)
networkid = 137

# Verbosity level for logging
# 0=silent, 1=error, 2=warn, 3=info, 4=debug, 5=detail
verbosity = 3

# Enable mining (set to false for full nodes)
mine = false

# JSON-RPC configuration
[jsonrpc]
  # Enable JSON-RPC over HTTP
  [jsonrpc.http]
    enabled = true
    host = "0.0.0.0"
    port = {{ env "BOR_RPC_PORT" }}
    api = ["eth", "net", "web3", "txpool", "bor"]
    corsdomain = ["*"]
    vhosts = ["*"]

  # Enable JSON-RPC over WebSocket
  [jsonrpc.ws]
    enabled = true
    host = "0.0.0.0"
    port = {{ env "BOR_WS_PORT" }}
    api = ["eth", "net", "web3", "txpool", "bor"]
    origins = ["*"]

  # Enable JSON-RPC over IPC
  [jsonrpc.ipc]
    disabled = false

# P2P networking configuration
[p2p]
  # Maximum number of peers to connect to
  maxpeers = 100

  # Discovery configuration
  [p2p.discovery]
    # Bootstrap nodes for network discovery - Updated June 2025
    bootnodes = {{ keyOrDefault "networks/polygon/bor/bootnodes" "[\"enode://e4fb013061eba9a2c6fb0a41bbd4149f4808f0fb7e88ec55d7163f19a6f02d64d0ce5ecc81528b769ba552a7068057432d44ab5e9e42842aff5b4709aa2c3f3b@34.89.75.187:30303\", \"enode://a49da6300403cf9b31e30502eb22c142ba4f77c9dda44990bccce9f2121c3152487ee95ee55c6b92d4cdce77845e40f59fd927da70ea91cf935b23e262236d75@34.142.43.249:30303\", \"enode://0e50fdcc2106b0c4e4d9ffbd7798ceda9432e680723dc7b7b4627e384078850c1c4a3e67f17ef2c484201ae6ee7c491cbf5e189b8ffee3948252e9bef59fc54e@35.234.148.172:30303\", \"enode://a0bc4dd2b59370d5a375a7ef9ac06cf531571005ae8b2ead2e9aaeb8205168919b169451fb0ef7061e0d80592e6ed0720f559bd1be1c4efb6e6c4381f1bdb986@35.246.99.203:30303\", \"enode://f2b0d50e0b843d38ddcab59614f93065e2c82130100032f86ae193eb874505de12fcaf12502dfd88e339b817c0b374fa4b4f7c4d5a4d1aa04f29c503d95e0228@35.197.233.240:30303\"]" }}

    # Static nodes to always connect to - Updated June 2025
    static-nodes = {{ keyOrDefault "networks/polygon/bor/static-nodes" "[\"enode://e4fb013061eba9a2c6fb0a41bbd4149f4808f0fb7e88ec55d7163f19a6f02d64d0ce5ecc81528b769ba552a7068057432d44ab5e9e42842aff5b4709aa2c3f3b@34.89.75.187:30303\", \"enode://a49da6300403cf9b31e30502eb22c142ba4f77c9dda44990bccce9f2121c3152487ee95ee55c6b92d4cdce77845e40f59fd927da70ea91cf935b23e262236d75@34.142.43.249:30303\", \"enode://0e50fdcc2106b0c4e4d9ffbd7798ceda9432e680723dc7b7b4627e384078850c1c4a3e67f17ef2c484201ae6ee7c491cbf5e189b8ffee3948252e9bef59fc54e@35.234.148.172:30303\", \"enode://a0bc4dd2b59370d5a375a7ef9ac06cf531571005ae8b2ead2e9aaeb8205168919b169451fb0ef7061e0d80592e6ed0720f559bd1be1c4efb6e6c4381f1bdb986@35.246.99.203:30303\", \"enode://f2b0d50e0b843d38ddcab59614f93065e2c82130100032f86ae193eb874505de12fcaf12502dfd88e339b817c0b374fa4b4f7c4d5a4d1aa04f29c503d95e0228@35.197.233.240:30303\"]" }}

    # Trusted nodes that are always allowed to connect - Updated June 2025
    trusted-nodes = {{ keyOrDefault "networks/polygon/bor/trusted-nodes" "[\"enode://e4fb013061eba9a2c6fb0a41bbd4149f4808f0fb7e88ec55d7163f19a6f02d64d0ce5ecc81528b769ba552a7068057432d44ab5e9e42842aff5b4709aa2c3f3b@34.89.75.187:30303\", \"enode://a49da6300403cf9b31e30502eb22c142ba4f77c9dda44990bccce9f2121c3152487ee95ee55c6b92d4cdce77845e40f59fd927da70ea91cf935b23e262236d75@34.142.43.249:30303\", \"enode://0e50fdcc2106b0c4e4d9ffbd7798ceda9432e680723dc7b7b4627e384078850c1c4a3e67f17ef2c484201ae6ee7c491cbf5e189b8ffee3948252e9bef59fc54e@35.234.148.172:30303\", \"enode://a0bc4dd2b59370d5a375a7ef9ac06cf531571005ae8b2ead2e9aaeb8205168919b169451fb0ef7061e0d80592e6ed0720f559bd1be1c4efb6e6c4381f1bdb986@35.246.99.203:30303\", \"enode://f2b0d50e0b843d38ddcab59614f93065e2c82130100032f86ae193eb874505de12fcaf12502dfd88e339b817c0b374fa4b4f7c4d5a4d1aa04f29c503d95e0228@35.197.233.240:30303\"]" }}

# Heimdall configuration
[heimdall]
  # URL of the Heimdall REST server
  url = {{ env "HEIMDALL_REST_URL" }}
  
  # Number of blocks to wait for confirmation from Heimdall
  # Default is 64, can be adjusted based on network conditions
  "bor.without-heimdall" = false

# Telemetry and metrics configuration
[telemetry]
  # Enable metrics collection
  metrics = true
  
  # Address to bind the metrics server
  addr = "0.0.0.0"
  
  # Port for the metrics server
  port = {{ env "BOR_PROM_PORT" }}

# Transaction pool configuration
[txpool]
  # Maximum number of pending transactions
  globals = 32768
  
  # Maximum number of transactions from a single account
  locals = 4096
  
  # Minimum gas price for transaction acceptance (in wei)
  pricelimit = 1000000000

# Cache configuration for better performance
[cache]
  # Cache size in MB
  cache = 4096
  
  # Cache configuration for contract state
  trie-cache-gens = 120

# Snapshot configuration (for fast sync)
[snapshot]
  # Enable snapshot generation
  snapshot = true

# Logging configuration
[log]
  # Log level: 0=silent, 1=error, 2=warn, 3=info, 4=debug, 5=detail
  level = 3
  
  # Enable JSON formatted logs
  json = true

# Node telemetry reporting to Polygon telemetry dashboard
# Set your unique node identity in the identity field above
[ethstats]
  # Format: "node_name:mainnet@polygon-rpc-mainnet.vitwit.com:3000"
  # The node_name should match the identity field
  enabled = {{ keyOrDefault "networks/polygon/bor/ethstats/enabled" "false" }}
  url = {{ keyOrDefault "networks/polygon/bor/ethstats/url" "\"polygon-full-node0:mainnet@bor-mainnet.vitwit.com:3000\"" }}

# Geth-compatible configuration
[geth]
  # Cache configuration
  "cache.database" = 512
  "cache.gc" = 256
  "cache.trie" = 256
  
  # Garbage collection configuration
  "gcmode" = "full"
  
  # State scheme configuration
  "state.scheme" = "hash"

# Developer mode (should be false for production)
dev = false

# Network configuration
[network]
  # Enable UPnP port mapping
  nat = "any" 