###
# SDK 0.46.x
###
# This is a TOML config file.
# For more information, see https://github.com/toml-lang/toml

# NOTE: Any path below can be absolute (e.g. "/var/myawesomeapp/data") or
# relative to the home directory (e.g. "data"). The home directory is
# "$HOME/.tendermint" by default, but could be changed via $TMHOME env variable
# or --home cmd flag.

#######################################################################
###                   Main Base Config Options                      ###
#######################################################################

# TCP or UNIX socket address of the ABCI application,
# or the name of an ABCI application compiled in with the Tendermint binary
proxy_app = "tcp://127.0.0.1:26658"

# A custom human readable name for this node
moniker = {{ keyOrDefault (print (env "CONSUL_PATH") "/base.moniker") "\"20k leagues under the sea\"" }}

# If this node is many blocks behind the tip of the chain, FastSync
# allows them to catchup quickly by downloading blocks in parallel
# and verifying their commits
fast_sync = true

# Database backend: goleveldb | cleveldb | boltdb | rocksdb | badgerdb
# * goleveldb (github.com/syndtr/goleveldb - most popular implementation)
#   - pure go
#   - stable
# * cleveldb (uses levigo wrapper)
#   - fast
#   - requires gcc
#   - use cleveldb build tag (go build -tags cleveldb)
# * boltdb (uses etcd's fork of bolt - github.com/etcd-io/bbolt)
#   - EXPERIMENTAL
#   - may be faster is some use-cases (random reads - indexer)
#   - use boltdb build tag (go build -tags boltdb)
# * rocksdb (uses github.com/tecbot/gorocksdb)
#   - EXPERIMENTAL
#   - requires gcc
#   - use rocksdb build tag (go build -tags rocksdb)
# * badgerdb (uses github.com/dgraph-io/badger)
#   - EXPERIMENTAL
#   - use badgerdb build tag (go build -tags badgerdb)
db_backend = "goleveldb"

# Database directory
db_dir = "data"

# Output level for logging, including package level options
log_level = {{ keyOrDefault  (print (env "CONSUL_PATH") "/base.log_level") "\"info\"" }}

# Output format: 'plain' (colored text) or 'json'
log_format = {{ keyOrDefault  (print (env "CONSUL_PATH") "/base.log_format") "\"json\"" }}

##### additional base config options #####

# Path to the JSON file containing the initial validator set and other meta data
genesis_file = "config/genesis.json"

# Path to the JSON file containing the private key to use as a validator in the consensus protocol
priv_validator_key_file = "config/priv_validator_key.json"

# Path to the JSON file containing the last sign state of a validator
priv_validator_state_file = "data/priv_validator_state.json"

# TCP or UNIX socket address for Tendermint to listen on for
# connections from an external PrivValidator process
priv_validator_laddr = {{ if (env "VALIDATOR") | parseBool }} "tcp://0.0.0.0:{{ env "NOMAD_PORT_tmkms" }}" {{ else }} "" {{ end }}

# Path to the JSON file containing the private key to use for node authentication in the p2p protocol
node_key_file = "config/node_key.json"

# Mechanism to connect to the ABCI application: socket | grpc
abci = "socket"

# If true, query the ABCI app on connecting to a new peer
# so the app can decide if we should keep the connection or not
filter_peers = false


#######################################################################
###                 Advanced Configuration Options                  ###
#######################################################################

#######################################################
###       RPC Server Configuration Options          ###
#######################################################
[rpc]

# TCP or UNIX socket address for the RPC server to listen on
laddr = "tcp://0.0.0.0:{{ env "NOMAD_PORT_rpc" }}"

# A list of origins a cross-domain request can be executed from
# Default value '[]' disables cors support
# Use '["*"]' to allow any origin
cors_allowed_origins = []

# A list of methods the client is allowed to use with cross-domain requests
cors_allowed_methods = ["HEAD", "GET", "POST", ]

# A list of non simple headers the client is allowed to use with cross-domain requests
cors_allowed_headers = ["Origin", "Accept", "Content-Type", "X-Requested-With", "X-Server-Time", ]

# TCP or UNIX socket address for the gRPC server to listen on
# NOTE: This server only supports /broadcast_tx_commit
grpc_laddr = ""

# Maximum number of simultaneous connections.
# Does not include RPC (HTTP&WebSocket) connections. See max_open_connections
# If you want to accept a larger number than the default, make sure
# you increase your OS limits.
# 0 - unlimited.
# Should be < {ulimit -Sn} - {MaxNumInboundPeers} - {MaxNumOutboundPeers} - {N of wal, db and other open files}
# 1024 - 40 - 10 - 50 = 924 = ~900
grpc_max_open_connections = 900

# Activate unsafe RPC commands like /dial_seeds and /unsafe_flush_mempool
unsafe = {{ keyOrDefault  (print (env "CONSUL_PATH") "/rpc.unsafe") "false" }}

# Maximum number of simultaneous connections (including WebSocket).
# Does not include gRPC connections. See grpc_max_open_connections
# If you want to accept a larger number than the default, make sure
# you increase your OS limits.
# 0 - unlimited.
# Should be < {ulimit -Sn} - {MaxNumInboundPeers} - {MaxNumOutboundPeers} - {N of wal, db and other open files}
# 1024 - 40 - 10 - 50 = 924 = ~900
max_open_connections = 900

# Maximum number of unique clientIDs that can /subscribe
# If you're using /broadcast_tx_commit, set to the estimated maximum number
# of broadcast_tx_commit calls per block.
max_subscription_clients = 100

# Maximum number of unique queries a given client can /subscribe to
# If you're using GRPC (or Local RPC client) and /broadcast_tx_commit, set to
# the estimated # maximum number of broadcast_tx_commit calls per block.
max_subscriptions_per_client = 5

# Experimental parameter to specify the maximum number of events a node will
# buffer, per subscription, before returning an error and closing the
# subscription. Must be set to at least 100, but higher values will accommodate
# higher event throughput rates (and will use more memory).
experimental_subscription_buffer_size = 200

# Experimental parameter to specify the maximum number of RPC responses that
# can be buffered per WebSocket client. If clients cannot read from the
# WebSocket endpoint fast enough, they will be disconnected, so increasing this
# parameter may reduce the chances of them being disconnected (but will cause
# the node to use more memory).
#
# Must be at least the same as "experimental_subscription_buffer_size",
# otherwise connections could be dropped unnecessarily. This value should
# ideally be somewhat higher than "experimental_subscription_buffer_size" to
# accommodate non-subscription-related RPC responses.
experimental_websocket_write_buffer_size = 200

# If a WebSocket client cannot read fast enough, at present we may
# silently drop events instead of generating an error or disconnecting the
# client.
#
# Enabling this experimental parameter will cause the WebSocket connection to
# be closed instead if it cannot read fast enough, allowing for greater
# predictability in subscription behaviour.
experimental_close_on_slow_client = false

# How long to wait for a tx to be committed during /broadcast_tx_commit.Update config.toml.tpl
# WARNING: Using a value larger than 10s will result in increasing the
# global HTTP write timeout, which applies to all connections and endpoints.
# See https://github.com/tendermint/tendermint/issues/3435
timeout_broadcast_tx_commit = "10s"

# Maximum size of request body, in bytes
max_body_bytes = 1000000

# Maximum size of request header, in bytes
max_header_bytes = 1048576

# The path to a file containing certificate that is used to create the HTTPS server.
# Might be either absolute path or path related to Tendermint's config directory.
# If the certificate is signed by a certificate authority,
# the certFile should be the concatenation of the server's certificate, any intermediates,
# and the CA's certificate.
# NOTE: both tls_cert_file and tls_key_file must be present for Tendermint to create HTTPS server.
# Otherwise, HTTP server is run.
tls_cert_file = ""

# The path to a file containing matching private key that is used to create the HTTPS server.
# Might be either absolute path or path related to Tendermint's config directory.
# NOTE: both tls-cert-file and tls-key-file must be present for Tendermint to create HTTPS server.
# Otherwise, HTTP server is run.
tls_key_file = ""

# pprof listen address (https://golang.org/pkg/net/http/pprof)
pprof_laddr = "0.0.0.0:{{ env "NOMAD_PORT_pprof" }}"

#######################################################
###           P2P Configuration Options             ###
#######################################################
[p2p]

# Address to listen for incoming connections
laddr = "tcp://0.0.0.0:{{ env "NOMAD_PORT_p2p" }}"

# Address to advertise to peers for them to dial
# If empty, will use the same port as the laddr,
# and will introspect on the listener or use UPnP
# to figure out the address. ip and port are required
# example: 159.89.10.97:26656
external_address = "{{ key (print (env "CONSUL_PATH") "/p2p.external_address") }}:{{ env "NOMAD_PORT_p2p" }}"

# Comma separated list of seed nodes to connect to
seeds = {{ keyOrDefault (print "networks/" (index (env "CONSUL_PATH" | split "/") 1) "/p2p.seeds") "\"\"" }}

# Comma separated list of nodes to keep persistent connections to
persistent_peers = {{ keyOrDefault  (print (env "CONSUL_PATH") "/p2p.persistent_peers") "\"\"" }}

# UPNP port forwarding
upnp = false

# Path to address book
addr_book_file = "config/addrbook.json"

# Set true for strict address routability rules
# Set false for private or local networks
addr_book_strict = {{ keyOrDefault (print (env "CONSUL_PATH") "/p2p.addr_book_strict") "true" }}

# Maximum number of inbound peers
max_num_inbound_peers = {{ keyOrDefault (print (env "CONSUL_PATH") "/p2p.max_num_inbound_peers") "5" }}

# Maximum number of outbound peers to connect to, excluding persistent peers
max_num_outbound_peers = {{ keyOrDefault (print (env "CONSUL_PATH") "/p2p.max_num_outbound_peers") "10" }}

# List of node IDs, to which a connection will be (re)established ignoring any existing limits
unconditional_peer_ids = {{ keyOrDefault (print "networks/" (index (env "CONSUL_PATH" | split "/") 1) "/p2p.unconditional_peer_ids") "\"\"" }}

# Maximum pause when redialing a persistent peer (if zero, exponential backoff is used)
persistent_peers_max_dial_period = "0s"

# Time to wait before flushing messages out on the connection
flush_throttle_timeout = "100ms"

# Maximum size of a message packet payload, in bytes
max_packet_msg_payload_size = {{ keyOrDefault (print "networks/" (index (env "CONSUL_PATH" | split "/") 1) "/p2p.max_packet_msg_payload_size") "1024" }}

# Rate at which packets can be sent, in bytes/second
send_rate = 51200000

# Rate at which packets can be received, in bytes/second
recv_rate = 51200000

# Set true to enable the peer-exchange reactor
pex = {{ keyOrDefault (print (env "CONSUL_PATH") "/p2p.pex") "false" }}

# Seed mode, in which node constantly crawls the network and looks for
# peers. If another node asks it for addresses, it responds and disconnects.
#
# Does not work if the peer-exchange reactor is disabled.
seed_mode = {{ keyOrDefault (print (env "CONSUL_PATH") "/p2p.seed_mode") "false" }}

# Comma separated list of peer IDs to keep private (will not be gossiped to other peers)
private_peer_ids = {{ keyOrDefault (print "networks/" (index (env "CONSUL_PATH" | split "/") 1) "/p2p.private_peer_ids") "\"\"" }}

# Toggle to disable guard against peers connecting from the same ip.
allow_duplicate_ip = {{ keyOrDefault (print (env "CONSUL_PATH") "/p2p.allow_duplicate_ip") "false" }}

# Peer connection configuration.
handshake_timeout = "20s"
dial_timeout = "3s"

#######################################################
###          Mempool Configuration Option          ###
#######################################################
[mempool]

# Mempool version to use:
#   1) "v0" - (default) FIFO mempool.
#   2) "v1" - prioritized mempool.
version = "v0"

recheck = true
broadcast = true
wal_dir = ""

# Maximum number of transactions in the mempool
size = {{ keyOrDefault (print "networks/" (index (env "CONSUL_PATH" | split "/") 1) "/mempool.size") "5000" }}

# Limit the total size of all txs in the mempool.
# This only accounts for raw transactions (e.g. given 1MB transactions and
# max_txs_bytes=5MB, mempool will only accept 5 transactions).
max_txs_bytes = 1073741824

# Size of the cache (used to filter transactions we saw earlier) in transactions
cache_size = 10000

# Do not remove invalid transactions from the cache (default: false)
# Set to true if it's not possible for any invalid transaction to become valid
# again in the future.
keep-invalid-txs-in-cache = false

# Maximum size of a single transaction.
# NOTE: the max size of a tx transmitted over the network is {max_tx_bytes}.
max_tx_bytes = 1048576

# Maximum size of a batch of transactions to send to a peer
# Including space needed by encoding (one varint per transaction).
# XXX: Unused due to https://github.com/tendermint/tendermint/issues/5796
max_batch_bytes = 0

# ttl-duration, if non-zero, defines the maximum amount of time a transaction
# can exist for in the mempool.
#
# Note, if ttl-num-blocks is also defined, a transaction will be removed if it
# has existed in the mempool at least ttl-num-blocks number of blocks or if it's
# insertion time into the mempool is beyond ttl-duration.
ttl-duration = {{ keyOrDefault (print (env "CONSUL_PATH") "/mempool.ttl-duration") "\"0s\"" }}

# ttl-num-blocks, if non-zero, defines the maximum number of blocks a transaction
# can exist for in the mempool.
#
# Note, if ttl-duration is also defined, a transaction will be removed if it
# has existed in the mempool at least ttl-num-blocks number of blocks or if
# it's insertion time into the mempool is beyond ttl-duration.
ttl-num-blocks = {{ keyOrDefault (print (env "CONSUL_PATH" | split "/") "/mempool.ttl-num-blocks") "0" }}

#######################################################
###         State Sync Configuration Options        ###
#######################################################
[statesync]
# State sync rapidly bootstraps a new node by discovering, fetching, and restoring a state machine
# snapshot from peers instead of fetching and replaying historical blocks. Requires some peers in
# the network to take and serve state machine snapshots. State sync is not attempted if the node
# has any local state (LastBlockHeight > 0). The node will have a truncated block history,
# starting from the height of the snapshot.
enable = {{ keyOrDefault (print (env "CONSUL_PATH") "/statesync.enable") "false" }}

# RPC servers (comma-separated) for light client verification of the synced state machine and
# retrieval of state data for node bootstrapping. Also needs a trusted height and corresponding
# header hash obtained from a trusted source, and a period during which validators can be trusted.
#
# For Cosmos SDK-based chains, trust_period should usually be about 2/3 of the unbonding time (~2
# weeks) during which they can be financially punished (slashed) for misbehavior.
rpc_servers = {{ keyOrDefault (print (env "CONSUL_PATH") "/statesync.rpc_servers") "\"\"" }}
trust_height = {{ keyOrDefault (print (env "CONSUL_PATH") "/statesync.trust_height") "0" }}
trust_hash = {{ keyOrDefault (print (env "CONSUL_PATH") "/statesync.trust_hash") "\"\"" }}
trust_period = {{ keyOrDefault (print "networks/" (index (env "CONSUL_PATH" | split "/") 1) "/statesync.trust_period") "\"168h0m0s\"" }}

# Time to spend discovering snapshots before initiating a restore.
discovery_time = "15s"

# Temporary directory for state sync snapshot chunks, defaults to the OS tempdir (typically /tmp).
# Will create a new, randomly named directory within, and remove it when done.
temp_dir = ""

# The timeout duration before re-requesting a chunk, possibly from a different
# peer (default: 1 minute).
chunk_request_timeout = "10s"

# The number of concurrent chunk fetchers to run (default: 1).
chunk_fetchers = "4"

#######################################################
###       Fast Sync Configuration Connections       ###
#######################################################
[fastsync]

# Fast Sync version to use:
#   1) "v0" (default) - the legacy fast sync implementation
#   2) "v1" - refactor of v0 version for better testability
#   2) "v2" - complete redesign of v0, optimized for testability & readability
version = "v0"

#######################################################
###         Consensus Configuration Options         ###
#######################################################
[consensus]

wal_file = "data/cs.wal/wal"

# How long we wait for a proposal block before prevoting nil
timeout_propose = "3s"
# How much timeout_propose increases with each round
timeout_propose_delta = "500ms"
# How long we wait after receiving +2/3 prevotes for “anything” (ie. not a single block or nil)
timeout_prevote = "1s"
# How much the timeout_prevote increases with each round
timeout_prevote_delta = "500ms"
# How long we wait after receiving +2/3 precommits for “anything” (ie. not a single block or nil)
timeout_precommit = "1s"
# How much the timeout_precommit increases with each round
timeout_precommit_delta = {{ keyOrDefault (print (env "CONSUL_PATH") "/consensus.timeout_precommit_delta") "\"500ms\"" }}
# How long we wait after committing a block, before starting on the new
# height (this gives us a chance to receive some more precommits, even
# though we already have +2/3).
timeout_commit = {{ keyOrDefault (print "networks/" (index (env "CONSUL_PATH" | split "/") 1) "/consensus.timeout_commit") "\"5s\"" }}

# How many blocks to look back to check existence of the node's consensus votes before joining consensus
# When non-zero, the node will panic upon restart
# if the same consensus key was used to sign {double_sign_check_height} last blocks.
# So, validators should stop the state machine, wait for some blocks, and then restart the state machine to avoid panic.
double_sign_check_height = {{ keyOrDefault (print (env "CONSUL_PATH") "/consensus.double_sign_check_height") "0" }}

# Make progress as soon as we have all the precommits (as if TimeoutCommit = 0)
skip_timeout_commit = {{ keyOrDefault (print "networks/" (index (env "CONSUL_PATH" | split "/") 1) "/consensus.skip_timeout_commit") "false" }}

# EmptyBlocks mode and possible interval between empty blocks
create_empty_blocks = true
create_empty_blocks_interval = "0s"

# Reactor sleep duration parameters
peer_gossip_sleep_duration = {{ keyOrDefault (print "networks/" (index (env "CONSUL_PATH" | split "/") 1) "/consensus.peer_gossip_sleep_duration") "\"100ms\"" }}
peer_query_maj23_sleep_duration = "2s"

#######################################################
###         Storage Configuration Options           ###
#######################################################
[storage]

# Set to true to discard ABCI responses from the state store, which can save a
# considerable amount of disk space. Set to false to ensure ABCI responses are
# persisted. ABCI responses are required for /block_results RPC queries, and to
# reindex events in the command-line tool.
discard_abci_responses = {{ keyOrDefault (print (env "CONSUL_PATH") "/storage.discard_abci_responses") "false" }}

#######################################################
###   Transaction Indexer Configuration Options     ###
#######################################################
[tx_index]

# What indexer to use for transactions
#
# The application will set which txs to index. In some cases a node operator will be able
# to decide which txs to index based on configuration set in the application.
#
# Options:
#   1) "null"
#   2) "kv" (default) - the simplest possible indexer, backed by key-value storage (defaults to levelDB; see DBBackend).
# 		- When "kv" is chosen "tx.height" and "tx.hash" will always be indexed.
#   3) "psql" - the indexer services backed by PostgreSQL.
# When "kv" or "psql" is chosen "tx.height" and "tx.hash" will always be indexed.
indexer = {{ keyOrDefault (print (env "CONSUL_PATH") "/indexer") "\"kv\"" }}

# The PostgreSQL connection configuration, the connection format:
#   postgresql://<user>:<password>@<host>:<port>/<db>?<opts>
psql-conn = {{ keyOrDefault  (print (env "CONSUL_PATH") "/tx_index.psql-conn") "\"\"" }}

#######################################################
###       Instrumentation Configuration Options     ###
#######################################################
[instrumentation]

# When true, Prometheus metrics are served under /metrics on
# PrometheusListenAddr.
# Check out the documentation for the list of available metrics.
prometheus = true

# Address to listen for Prometheus collector(s) connections
prometheus_listen_addr = ":{{ env "NOMAD_PORT_prom" }}"

# Maximum number of simultaneous connections.
# If you want to accept a larger number than the default, make sure
# you increase your OS limits.
# 0 - unlimited.
max_open_connections = 3

# Instrumentation namespace
namespace = "tendermint"

##### Axelar EVM bridges options #####
# Each EVM chain needs the following
# 1. `[[axelar_bridge_evm]]` # header
# 2. `name`                  # chain name (eg. "Ethereum")
# 3. 'rpc_addr'              # EVM RPC endpoint URL; chain maintainers set their own endpoint
# 4. `start-with-bridge`     # `true` to support this chain
#
# see https://docs.axelar.dev/#/validator-zone/external-chains/overview

[[axelar_bridge_evm]]
name = "Ethereum"
rpc_addr = {{ keyOrDefault  (print (env "CONSUL_PATH") "/bridge.eth.rpc") "\"\"" }}
start-with-bridge = {{ keyOrDefault (print (env "CONSUL_PATH") "/bridge.eth.enable") "false" }}

[[axelar_bridge_evm]]
name = "ethereum-2"
rpc_addr = {{ keyOrDefault  (print (env "CONSUL_PATH") "/bridge.eth-goerli.rpc") "\"\"" }}
start-with-bridge = {{ keyOrDefault (print (env "CONSUL_PATH") "/bridge.eth-goerli.enable") "false" }}

[[axelar_bridge_evm]]
name = "Avalanche"
rpc_addr = {{ keyOrDefault  (print (env "CONSUL_PATH") "/bridge.avalanche.rpc") "\"\"" }}
start-with-bridge = {{ keyOrDefault (print (env "CONSUL_PATH") "/bridge.avalanche.enable") "false" }}

[[axelar_bridge_evm]]
name = "Fantom"
rpc_addr = {{ keyOrDefault  (print (env "CONSUL_PATH") "/bridge.fantom.rpc") "\"\"" }}
start-with-bridge = {{ keyOrDefault (print (env "CONSUL_PATH") "/bridge.fantom.enable") "false" }}

[[axelar_bridge_evm]]
name = "Moonbeam"
rpc_addr = {{ keyOrDefault  (print (env "CONSUL_PATH") "/bridge.moonbeam.rpc") "\"\"" }}
start-with-bridge = {{ keyOrDefault (print (env "CONSUL_PATH") "/bridge.moonbeam.enable") "false" }}

[[axelar_bridge_evm]]
name = "Polygon"
rpc_addr = {{ keyOrDefault  (print (env "CONSUL_PATH") "/bridge.polygon.rpc") "\"\"" }}
start-with-bridge = {{ keyOrDefault (print (env "CONSUL_PATH") "/bridge.polygon.enable") "false" }}

[[axelar_bridge_evm]]
name = "binance"
rpc_addr = {{ keyOrDefault  (print (env "CONSUL_PATH") "/bridge.binance.rpc") "\"\"" }}
start-with-bridge = {{ keyOrDefault (print (env "CONSUL_PATH") "/bridge.binance.enable") "false" }}

[[axelar_bridge_evm]]
name = "aurora"
rpc_addr = {{ keyOrDefault  (print (env "CONSUL_PATH") "/bridge.aurora.rpc") "\"\"" }}
start-with-bridge = {{ keyOrDefault (print (env "CONSUL_PATH") "/bridge.aurora.enable") "false" }}

[[axelar_bridge_evm]]
name = "arbitrum"
l1_chain_name = {{ keyOrDefault (print (env "CONSUL_PATH") "/bridge.arbitrum.l1_chain_name") "\"\"" }}
rpc_addr = {{ keyOrDefault  (print (env "CONSUL_PATH") "/bridge.arbitrum.rpc") "\"\"" }}
start-with-bridge = {{ keyOrDefault (print (env "CONSUL_PATH") "/bridge.arbitrum.enable") "false" }}

[[axelar_bridge_evm]]
name = "celo"
rpc_addr = {{ keyOrDefault  (print (env "CONSUL_PATH") "/bridge.celo.rpc") "\"\"" }}
start-with-bridge = {{ keyOrDefault (print (env "CONSUL_PATH") "/bridge.celo.enable") "false" }}

[[axelar_bridge_evm]]
name = "kava"
rpc_addr = {{ keyOrDefault  (print (env "CONSUL_PATH") "/bridge.kava.rpc") "\"\"" }}
start-with-bridge = {{ keyOrDefault (print (env "CONSUL_PATH") "/bridge.kava.enable") "false" }}

[[axelar_bridge_evm]]
name = "filecoin"
rpc_addr = {{ keyOrDefault  (print (env "CONSUL_PATH") "/bridge.filecoin.rpc") "\"\"" }}
start-with-bridge = {{ keyOrDefault (print (env "CONSUL_PATH") "/bridge.filecoin.enable") "false" }}

##### message broadcasting options #####
[broadcast]

broadcaster-account = "broadcaster"
gas-adjustment = 1.0
max-retries = 10
min-timeout = "4s"

### SKIP the dishes
[sidecar]
sentinel_peer_string = {{ keyOrDefault  (print (env "CONSUL_PATH") "/sidecar.sentinel_peer_string") "\"\"" }}
sentinel_rpc_string = {{ keyOrDefault  (print (env "CONSUL_PATH") "/sidecar.sentinel_rpc_string") "\"\"" }}
api_key = {{ keyOrDefault  (print (env "CONSUL_PATH") "/sidecar.api_key") "\"\"" }}
personal_peer_ids = {{ keyOrDefault  (print (env "CONSUL_PATH") "/sidecar.personal_peer_ids") "\"\"" }}
