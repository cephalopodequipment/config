###
# SDK 0.47.x
###
# This is a TOML config file.
# For more information, see https://github.com/toml-lang/toml

###############################################################################
###                           Base Configuration                            ###
###############################################################################

# The minimum gas prices a validator is willing to accept for processing a
# transaction. A transaction's fees must meet the minimum of any denomination
# specified in this config (e.g. 0.25token1;0.0001token2).
minimum-gas-prices = {{ key (print (env "CONSUL_PATH") "/base.minimum-gas-prices") }}

# default: the last 362880 states are kept, pruning at 10 block intervals
# nothing: all historic states will be saved, nothing will be deleted (i.e. archiving node)
# everything: 2 latest states will be kept; pruning at 10 block intervals.
# custom: allow pruning options to be manually specified through 'pruning-keep-recent', and 'pruning-interval'
pruning = {{ keyOrDefault (print (env "CONSUL_PATH") "/base.pruning") "\"default\"" }}

# These are applied if and only if the pruning strategy is custom.
pruning-keep-recent = {{ keyOrDefault (print (env "CONSUL_PATH") "/base.pruning-keep-recent") "0" }}
pruning-interval = {{ keyOrDefault (print (env "CONSUL_PATH") "/base.pruning-interval") "0" }}

# HaltHeight contains a non-zero block height at which a node will gracefully
# halt and shutdown that can be used to assist upgrades and testing.
#
# Note: Commitment of state will be attempted on the corresponding block.
halt-height = {{ keyOrDefault (print "networks/" (index (env "CONSUL_PATH" | split "/") 1) "/base.halt-height") "0" }}

# HaltTime contains a non-zero minimum block time (in Unix seconds) at which
# a node will gracefully halt and shutdown that can be used to assist upgrades
# and testing.
#
# Note: Commitment of state will be attempted on the corresponding block.
halt-time = 0

# MinRetainBlocks defines the minimum block height offset from the current
# block being committed, such that all blocks past this offset are pruned
# from Tendermint. It is used as part of the process of determining the
# ResponseCommit.RetainHeight value during ABCI Commit. A value of 0 indicates
# that no blocks should be pruned.
#
# This configuration value is only responsible for pruning Tendermint blocks.
# It has no bearing on application state pruning which is determined by the
# "pruning-*" configurations.
#
# Note: Tendermint block pruning is dependant on this parameter in conunction
# with the unbonding (safety threshold) period, state pruning and state sync
# snapshot parameters to determine the correct minimum value of
# ResponseCommit.RetainHeight.
min-retain-blocks = {{ keyOrDefault (print (env "CONSUL_PATH") "/base.min-retain-blocks") "0" }}

# InterBlockCache enables inter-block caching.
inter-block-cache = true

# IndexEvents defines the set of events in the form {eventType}.{attributeKey},
# which informs Tendermint what to index. If empty, all events will be indexed.
#
# Example:
# ["message.sender", "message.recipient"]
index-events = []

# IavlCacheSize set the size of the iavl tree cache.
iavl-cache-size = {{ keyOrDefault (print (env "CONSUL_PATH") "/base.iavl-cache-size") "781250" }}

# IAVLDisableFastNode enables or disables the fast node feature of IAVL. 
# Default is false.
iavl-disable-fastnode = {{ keyOrDefault (print (env "CONSUL_PATH") "/base.iavl-disable-fastnode") "false" }}

# IAVLLazyLoading enable/disable the lazy loading of iavl store.
# Default is false.
iavl-lazy-loading = false

# AppDBBackend defines the database backend type to use for the application and snapshots DBs.
# An empty string indicates that a fallback will be used.
# First fallback is the deprecated compile-time types.DBBackend value.
# Second fallback (if the types.DBBackend also isn't set), is the db-backend value set in Tendermint's config.toml.
app-db-backend = ""

###############################################################################
###                         Telemetry Configuration                         ###
###############################################################################

[telemetry]

# Prefixed with keys to separate services.
service-name = ""

# Enabled enables the application telemetry functionality. When enabled,
# an in-memory sink is also enabled by default. Operators may also enabled
# other sinks such as Prometheus.
enabled = {{ keyOrDefault (print (env "CONSUL_PATH") "/telemetry.enabled") "false" }}

# Enable prefixing gauge values with hostname.
enable-hostname = false

# Enable adding hostname to labels.
enable-hostname-label = false

# Enable adding service to labels.
enable-service-label = false

# PrometheusRetentionTime, when positive, enables a Prometheus metrics sink.
prometheus-retention-time = {{ keyOrDefault (print (env "CONSUL_PATH") "/telemetry.prometheus-retention-time") "0" }}

# GlobalLabels defines a global set of name/value label tuples applied to all
# metrics emitted using the wrapper functions defined in telemetry package.
#
# Example:
# [["chain_id", "cosmoshub-1"]]
global-labels = [
]

###############################################################################
###                           API Configuration                             ###
###############################################################################

[api]

# Enable defines if the API server should be enabled.
enable = true

# Swagger defines if swagger documentation should automatically be registered.
swagger = true

# Address defines the API server to listen on.
address = "tcp://0.0.0.0:1317"

# MaxOpenConnections defines the number of maximum open connections.
max-open-connections = 1000

# RPCReadTimeout defines the Tendermint RPC read timeout (in seconds).
rpc-read-timeout = 10

# RPCWriteTimeout defines the Tendermint RPC write timeout (in seconds).
rpc-write-timeout = 0

# RPCMaxBodyBytes defines the Tendermint maximum request body (in bytes).
rpc-max-body-bytes = 1000000

# EnableUnsafeCORS defines if CORS should be enabled (unsafe - use it at your own risk).
enabled-unsafe-cors = false

###############################################################################
###                           Rosetta Configuration                         ###
###############################################################################

[rosetta]

# Enable defines if the Rosetta API server should be enabled.
enable = false

# Address defines the Rosetta API server to listen on.
address = ":8080"

# Network defines the name of the blockchain that will be returned by Rosetta.
blockchain = "app"

# Network defines the name of the network that will be returned by Rosetta.
network = "network"

# Retries defines the number of retries when connecting to the node before failing.
retries = 3

# Offline defines if Rosetta server should run in offline mode.
offline = false

# EnableDefaultSuggestedFee defines if the server should suggest fee by default.
# If 'construction/medata' is called without gas limit and gas price,
# suggested fee based on gas-to-suggest and denom-to-suggest will be given.
enable-fee-suggestion = {{ keyOrDefault (print (env "CONSUL_PATH") "/rosetta.enable-fee-suggestion") "false" }}

# GasToSuggest defines gas limit when calculating the fee
gas-to-suggest = {{ keyOrDefault (print (env "CONSUL_PATH") "/rosetta.gas-to-suggest") "200000" }}

# DenomToSuggest defines the defult denom for fee suggestion.
# Price must be in minimum-gas-prices.
denom-to-suggest = {{ keyOrDefault (print (env "CONSUL_PATH") "/rosetta.denom-to-suggest") "\"uatom\"" }}

###############################################################################
###                           gRPC Configuration                            ###
###############################################################################

[grpc]

# Enable defines if the gRPC server should be enabled.
enable = true

# Address defines the gRPC server address to bind to.
address = "0.0.0.0:9090"

# MaxRecvMsgSize defines the max message size in bytes the server can receive.
# The default value is 10MB.
max-recv-msg-size = "10485760"

# MaxSendMsgSize defines the max message size in bytes the server can send.
# The default value is math.MaxInt32.
max-send-msg-size = "2147483647"

###############################################################################
###                        gRPC Web Configuration                           ###
###############################################################################

[grpc-web]

# GRPCWebEnable defines if the gRPC-web should be enabled.
# NOTE: gRPC must also be enabled, otherwise, this configuration is a no-op.
enable = true

# Address defines the gRPC-web server address to bind to.
address = "0.0.0.0:9091"

# EnableUnsafeCORS defines if CORS should be enabled (unsafe - use it at your own risk).
enable-unsafe-cors = false

###############################################################################
###                        State Sync Configuration                         ###
###############################################################################

# State sync snapshots allow other nodes to rapidly join the network without replaying historical
# blocks, instead downloading and applying a snapshot of the application state at a given height.
[state-sync]

# snapshot-interval specifies the block interval at which local state sync snapshots are
# taken (0 to disable).
snapshot-interval = {{ keyOrDefault (print (env "CONSUL_PATH") "/statesync.snapshot-interval") "0" }}

# snapshot-keep-recent specifies the number of recent snapshots to keep and serve (0 to keep all).
snapshot-keep-recent = {{ keyOrDefault (print (env "CONSUL_PATH") "/statesync.snapshot-keep-recent") "2" }}

###############################################################################
###                         Store / State Streaming                         ###
###############################################################################

[store]
streamers = []

[streamers]
[streamers.file]
keys = ["*", ]
write_dir = ""
prefix = ""

# output-metadata specifies if output the metadata file which includes the abci request/responses 
# during processing the block.
output-metadata = "true"

# stop-node-on-error specifies if propagate the file streamer errors to consensus state machine.
stop-node-on-error = "true"

# fsync specifies if call fsync after writing the files.
fsync = "false"

###############################################################################
###                         Mempool                                         ###
###############################################################################

[mempool]
# Setting max-txs to 0 will allow for a unbounded amount of transactions in the mempool.
# Setting max_txs to negative 1 (-1) will disable transactions from being inserted into the mempool.
# Setting max_txs to a positive number (> 0) will limit the number of transactions in the mempool, by the specified amount.
#
# Note, this configuration only applies to SDK built-in app-side mempool
# implementations.
max-txs = "5000"

###############################################################################
###                      Osmosis Mempool Configuration                      ###
###############################################################################

[osmosis-mempool]
# This is the max allowed gas any tx.
# This is only for local mempool purposes, and thus	is only ran on check tx.
max-gas-wanted-per-tx = {{ keyOrDefault (print (env "CONSUL_PATH") "/osmo-mempool.max-gas-wanted-per-tx") "\"25000000\"" }}

# This is the minimum gas fee any arbitrage tx should have, denominated in uosmo per gas
# Default value of ".1" then means that a tx with 1 million gas costs (.1 uosmo/gas) * 1_000_000 gas = .1 osmo
arbitrage-min-gas-fee = {{ keyOrDefault (print (env "CONSUL_PATH") "/osmo-mempool.arbitrage-min-gas-fee") "\"10\"" }}

# This is the minimum gas fee any tx with high gas demand should have, denominated in uosmo per gas
# Default value of ".0025" then means that a tx with 1 million gas costs (.0025 uosmo/gas) * 1_000_000 gas = .0025 osmo
min-gas-price-for-high-gas-tx = {{ keyOrDefault (print (env "CONSUL_PATH") "/osmo-mempool.min-gas-price-for-high-gas-tx") "\"0.01\"" }}

# This parameter enables EIP-1559 like fee market logic in the mempool
adaptive-fee-enabled = {{ keyOrDefault (print (env "CONSUL_PATH") "/osmo-mempool.adaptive-fee-enabled") "\"true\"" }}

###############################################################################
###                         WASM                                            ###
###############################################################################

[wasm]
# This is the maximum sdk gas (wasm and storage) that we allow for any x/wasm "smart" queries
query_gas_limit = 1000000
# This defines the memory size for Wasm modules that we can keep cached to speed-up instantiation
# The value is in MiB not bytes
memory_cache_size = 3000
