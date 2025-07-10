# Polygon Bor v2.0.0 Configuration File
# Based on official v2.0.0 defaults with team parameterization

# Chain configuration
chain = "mainnet"
identity = "{{ keyOrDefault "networks/polygon/bor/identity" "polygon-full-node0" }}"
verbosity = 3
datadir = "/bor-home"
syncmode = "full"
gcmode = "full"
"state.scheme" = "path"
snapshot = true

# Database engine (pebble is default in v2.0.0)
"db.engine" = "pebble"

# Logging configuration
[log]
  json = true

# P2P networking configuration
[p2p]
  maxpeers = {{ keyOrDefault (print (env "CONSUL_PATH") "/bor.maxpeers") 2000 }}
  maxpendpeers = {{ keyOrDefault (print (env "CONSUL_PATH") "/bor.maxpendpeers") 500 }}
  bind = "0.0.0.0"
  port = {{ env "BOR_P2P_PORT" }}
  nat = "any"
  
  [p2p.discovery]
    # Official Polygon mainnet bootnodes - Updated January 2025
    bootnodes = {{ keyOrDefault "networks/polygon/bor/bootnodes" "[\"enode://e4fb013061eba9a2c6fb0a41bbd4149f4808f0fb7e88ec55d7163f19a6f02d64d0ce5ecc81528b769ba552a7068057432d44ab5e9e42842aff5b4709aa2c3f3b@34.89.75.187:30303\", \"enode://a49da6300403cf9b31e30502eb22c142ba4f77c9dda44990bccce9f2121c3152487ee95ee55c6b92d4cdce77845e40f59fd927da70ea91cf935b23e262236d75@34.142.43.249:30303\", \"enode://0e50fdcc2106b0c4e4d9ffbd7798ceda9432e680723dc7b7b4627e384078850c1c4a3e67f17ef2c484201ae6ee7c491cbf5e189b8ffee3948252e9bef59fc54e@35.234.148.172:30303\", \"enode://a0bc4dd2b59370d5a375a7ef9ac06cf531571005ae8b2ead2e9aaeb8205168919b169451fb0ef7061e0d80592e6ed0720f559bd1be1c4efb6e6c4381f1bdb986@35.246.99.203:30303\", \"enode://f2b0d50e0b843d38ddcab59614f93065e2c82130100032f86ae193eb874505de12fcaf12502dfd88e339b817c0b374fa4b4f7c4d5a4d1aa04f29c503d95e0228@35.197.233.240:30303\", \"enode://72c3176693f7100dfedc8a37909120fea16971260a5d95ceff49affbc0e23968c35655fee75734736f0b038147645e8ceeee59af68859b3f5bf91fe249be6259@35.246.95.65:30303\", \"enode://f0e44769385aea31de930d3f4796e3e348962221063bb9f681106d832d13f70e5543d652d30e819812104f1b1ffdd7585977b46bf802ed5a52cf731de8c48dbd@34.105.180.11:30303\", \"enode://fc7624241515f9d5e599a396362c29de92b13a048ad361c90dd72286aa4cca835ba65e140a46ace70cc4dcb18472a476963750b3b69d958c5f546d48675880a8@34.147.169.102:30303\", \"enode://198896e373735ba38a0313d073137a413787ece791fbc0d0be0f9f6b9d9dd00ee0841f46519904d666d7f1cdfce5532b093e3a1574b34eb64224f57b9b7fce7b@34.89.55.74:30303\"]" }}
    static-nodes = {{ keyOrDefault "networks/polygon/bor/static-nodes" "[]" }}
    trusted-nodes = {{ keyOrDefault "networks/polygon/bor/trusted-nodes" "[]" }}
    # DNS discovery for enhanced peering (mainnet)
    dns = {{ keyOrDefault "networks/polygon/bor/dns-discovery" "[\"enrtree://AKUEZKN7PSKVNR65FZDHECMKOJQSGPARGTPPBI7WS2VUL4EGR6XPC@pos.polygon-peers.io\"]" }}

# Heimdall configuration
[heimdall]
  url = "{{ env "HEIMDALL_REST_URL" }}"
  "bor.without" = false

# Transaction pool configuration (using defaults for fullnode)
[txpool]
  pricelimit = 25000000000
  accountslots = 16
  globalslots = 131072
  accountqueue = 64
  globalqueue = 131072

# Mining configuration (disabled for full nodes)
[miner]
  mine = false
  gaslimit = 30000000

# JSON-RPC configuration - CRITICAL: Must be enabled!
[jsonrpc]
  [jsonrpc.http]
    enabled = true
    port = {{ env "BOR_RPC_PORT" }}
    host = "0.0.0.0"
    api = ["eth", "net", "web3", "txpool", "bor"]
    vhosts = ["*"]
    corsdomain = ["*"]
  
  [jsonrpc.ws]
    enabled = true
    port = {{ env "BOR_WS_PORT" }}
    host = "0.0.0.0"
    api = ["eth", "net", "web3", "txpool", "bor"]
    origins = ["*"]

# Telemetry and metrics configuration
[telemetry]
  metrics = true
  prometheus-addr = "0.0.0.0:{{ env "BOR_PROM_PORT" }}"

# Cache configuration (using defaults for fullnode)
[cache]
  cache = 4096
  gc = 25
  snapshot = 10
  database = 50
  trie = 15

# Parallel EVM (new in v2.0.0)
[parallelevm]
  enable = true
  procs = 8

# Performance profiling (disabled for fullnode)
[pprof]
  pprof = false
  port = 6060
  addr = "127.0.0.1"
