# This is a TOML config file for Heimdall v2 application settings.
# For more information, see https://github.com/toml-lang/toml

###############################################################################
###                           Base Configuration                            ###
###############################################################################

# The minimum gas prices a validator is willing to accept for processing a
# transaction. A transaction's fees must meet the minimum of any denomination
# specified in this config (e.g. 0.25token1;0.0001token2).
minimum-gas-prices = ""

# default: the last 362880 states are kept, pruning at 10 block intervals
# nothing: all historic states will be saved, nothing will be deleted (i.e. archiving node)
# everything: 2 latest states will be kept; pruning at 10 block intervals.
# custom: allow pruning options to be manually specified through 'pruning-keep-recent', and 'pruning-interval'
pruning = "default"

# These are applied if and only if the pruning strategy is custom.
pruning-keep-recent = "0"
pruning-interval = "0"

# HaltHeight contains a non-zero block height at which a node will gracefully
# halt and shutdown that can be used to assist upgrades and testing.
#
# Note: Commitment of state will be attempted even if the node is configured to
# halt during BeginBlock. However, it is not guaranteed. Thus, it is recommended
# to leave this value empty and manually shut down the node when needed.
halt-height = 0

# HaltTime contains a non-zero minimum block time (in Unix seconds) at which
# a node will gracefully halt and shutdown that can be used to assist upgrades
# and testing.
#
# Note: Commitment of state will be attempted even if the node is configured to
# halt during BeginBlock. However, it is not guaranteed. Thus, it is recommended
# to leave this value empty and manually shut down the node when needed.
halt-time = 0

# MinRetainBlocks defines the minimum block height offset from the current
# block being committed, such that all blocks past this offset are pruned
# from CometBFT. It is used as part of the process of determining the
# ResponseCommit.RetainHeight value during ABCI Commit. A value of 0 indicates
# that no blocks should be pruned.
#
# This configuration value is only responsible for pruning CometBFT blocks.
# It has no bearing on application state pruning which is determined by the
# "pruning-*" configurations.
#
# Note: CometBFT block pruning is dependant on this parameter in conjunction
# with the unbonding (safety threshold) period, state pruning and state sync
# snapshot parameters to determine the correct minimum value of
# ResponseCommit.RetainHeight.
min-retain-blocks = 0

# InterBlockCache enables inter-block caching.
inter-block-cache = true

# IndexEvents defines the set of events in the form {eventType}.{attributeKey},
# which informs CometBFT what to index. If empty, all events will be indexed.
#
# Example:
# ["message.sender", "message.recipient"]
index-events = []

# IavlCacheSize set the size of the iavl tree cache (in number of nodes).
iavl-cache-size = 781250

# IAVLDisableFastNode enables or disables the fast node feature of IAVL. 
# Default is false.
iavl-disable-fastnode = false

# AppDBBackend defines the database backend type to use for the application and snapshots DBs.
# An empty string indicates that a fallback will be used.
# The fallback is the db_backend value set in CometBFT's config.toml.
app-db-backend = ""

###############################################################################
###                         Telemetry Configuration                        ###
###############################################################################

[telemetry]

# Prefixed with keys to separate services.
service-name = ""

# Enabled enables the application telemetry functionality. When enabled,
# an in-memory sink is also enabled by default. Operators may also enabled
# other sinks such as Prometheus.
enabled = false

# Enable prefixing gauge values with hostname.
enable-hostname = false

# Enable adding hostname to labels.
enable-hostname-label = false

# Enable adding service to labels.
enable-service-label = false

# PrometheusRetentionTime, when positive, enables a Prometheus metrics sink.
prometheus-retention-time = 0

# GlobalLabels defines a global set of name/value label tuples applied to all
# metrics emitted using the wrapper functions defined in telemetry package.
#
# Example:
# [["chain_id", "cosmoshub-1"]]
global-labels = [
]

###############################################################################
###                           API Configuration                            ###
###############################################################################

[api]

# Enable defines if the API server should be enabled.
enable = true

# Swagger defines if swagger documentation should automatically be registered.
swagger = false

# Address defines the API server to listen on.
address = "tcp://0.0.0.0:1317"

# MaxOpenConnections defines the number of maximum open connections.
max-open-connections = 1000

# RPCReadTimeout defines the CometBFT RPC read timeout (in seconds).
rpc-read-timeout = 10

# RPCWriteTimeout defines the CometBFT RPC write timeout (in seconds).
rpc-write-timeout = 0

# RPCMaxBodyBytes defines the CometBFT maximum request body (in bytes).
rpc-max-body-bytes = 1000000

# EnableUnsafeCORS defines if CORS should be enabled (unsafe - use it at your own risk).
enabled-unsafe-cors = false

###############################################################################
###                           Rosetta Configuration                        ###
###############################################################################

[rosetta]

# Enable defines if the Rosetta API server should be enabled.
enable = false

# Address defines the Rosetta API server to listen on.
address = ":8080"

# Network defines the name of the blockchain that will be returned in Rosetta interface.
blockchain = "app"

# Network defines the name of the network that will be returned in Rosetta interface.
network = "network"

# Retries defines the number of retries when connecting to the node before failing.
retries = 3

# Offline defines if Rosetta server should run in offline mode.
offline = false

# EnableDefaultSuggestedFee defines if the server should suggest fee by default.
# If 'construction/medata' is called without gas limit and gas price,
# suggested fee based on gas-to-suggest and denom-to-suggest will be given.
enable-fee-suggestion = false

# GasToSuggest defines gas limit when calculating the fee
gas-to-suggest = 210000

# DenomToSuggest defines the defult denom for fee suggestion.
# Price must be in minimum-gas-prices.
denom-to-suggest = "uatom"

###############################################################################
###                           gRPC Configuration                           ###
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
###                        gRPC Web Configuration                          ###
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
###                        State Sync Configuration                        ###
###############################################################################

# State sync snapshots allow other nodes to rapidly join the network without replaying historical
# blocks, instead downloading and applying a snapshot of the application state at a given height.
[state-sync]

# snapshot-interval specifies the block interval at which local state sync snapshots are
# taken (0 to disable).
snapshot-interval = 0

# snapshot-keep-recent specifies the number of recent snapshots to keep and serve (0 to keep all).
snapshot-keep-recent = 2

###############################################################################
###                         Store / State Streaming                        ###
###############################################################################

[streaming]

# ABCI.Listen defines the list of ABCI listeners to invoke during ABCI method calls.
abci.listen = []

# ABCI.Plugin defines the list of plugins to load for ABCI streaming.
abci.plugin = []

# ABCI.StopNodeOnErr defines whether to stop the node on message delivery error.
abci.stop-node-on-err = true

###############################################################################
###                             Mempool                                    ###
###############################################################################

[mempool]
# Setting max-txs to 0 will allow for a unbounded amount of transactions in the mempool.
# Setting max_txs to negative will disable transactions from being inserted into the mempool.
# Setting max_txs to a positive number (n) will limit the number of transactions in the mempool to n.
max-txs = 5000

###############################################################################
###                         Custom Heimdall Configuration                  ###
###############################################################################

[custom]

# RPC endpoint for ethereum chain - using fallback URL
eth_rpc_url = "https://ethereum.publicnode.com"

# RPC endpoint for bor chain - using service discovery with fallback
bor_rpc_url = "{{ range service "polygon-execution-rpc" }}http://{{ .Address }}:{{ .Port }}{{ else }}http://127.0.0.1:8545{{ end }}"

# GRPC flag for bor chain
bor_grpc_flag = false

# GRPC endpoint for bor chain
bor_grpc_url = "localhost:3131"

# RPC timeout for bor
bor_rpc_timeout = "1s"

# RPC endpoint for tendermint
tendermint_rpc_url = "http://127.0.0.1:{{ env "NOMAD_PORT_rpc" }}"

# Polygon Sub Graph URL for self-heal mechanism (optional)
sub_graph_url = ""

#### Bridge configs ####

# Heimdall REST server endpoint, which is used by bridge
heimdall_rest_server = "http://127.0.0.1:{{ env "NOMAD_PORT_heimdall_rest" }}"

# AMQP endpoint
amqp_url = "amqp://guest:guest@localhost:5672/"

## Poll intervals (using defaults for fullnode)
checkpoint_poll_interval = "5m0s"
syncer_poll_interval = "1m0s"
noack_poll_interval = "16m50s"
clerk_poll_interval = "10s"
span_poll_interval = "1m0s"
milestone_poll_interval = "30s"
enable_self_heal = "false"
sh_state_synced_interval = "15m0s"
sh_stake_update_interval = "3h0m0s"
sh_max_depth_duration = "1h0m0s"

#### gas limits ####
main_chain_gas_limit = "5000000"

#### gas price ####
main_chain_max_gas_price = "400000000000"

##### Timeout Config #####
no_ack_wait_time = "30m0s"

##### chain - newSelectionAlgoHeight depends on this #####
chain = "mainnet"
