###
# SDK 0.53.x
###
# This is a TOML config file.
# For more information, see https://github.com/toml-lang/toml

###############################################################################
###                           Base Configuration                            ###
###############################################################################

# The minimum gas prices a validator is willing to accept for processing a
# transaction. A transaction's fees must meet the minimum of any denomination
# specified in this config (e.g. 0.25token1,0.0001token2).
minimum-gas-prices = {{ key (print (env "CONSUL_PATH") "/base.minimum-gas-prices") }}

# The maximum gas a query coming over rest/grpc may consume.
# If this is set to zero, the query can consume an unbounded amount of gas.
query-gas-limit = {{ key (print (env "CONSUL_PATH") "/base.query-gas-limit") }}

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
min-retain-blocks = {{ keyOrDefault (print (env "CONSUL_PATH") "/base.min-retain-blocks") "0" }}

# InterBlockCache enables inter-block caching.
inter-block-cache = true

# IndexEvents defines the set of events in the form {eventType}.{attributeKey},
# which informs CometBFT what to index. If empty, all events will be indexed.
#
# Example:
# ["message.sender", "message.recipient"]
index-events = []

# IavlCacheSize set the size of the iavl tree cache (in number of nodes).
iavl-cache-size = {{ keyOrDefault (print (env "CONSUL_PATH") "/base.iavl-cache-size") "781250" }}

# IAVLDisableFastNode enables or disables the fast node feature of IAVL. 
# Default is false.
iavl-disable-fastnode = {{ keyOrDefault (print (env "CONSUL_PATH") "/base.iavl-disable-fastnode") "false" }}

# AppDBBackend defines the database backend type to use for the application and snapshots DBs.
# An empty string indicates that a fallback will be used.
# The fallback is the db_backend value set in CometBFT's config.toml.
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

# MetricsSink defines the type of metrics sink to use.
metrics-sink = ""

# StatsdAddr defines the address of a statsd server to send metrics to.
# Only utilized if MetricsSink is set to "statsd" or "dogstatsd".
statsd-addr = ""

# DatadogHostname defines the hostname to use when emitting metrics to
# Datadog. Only utilized if MetricsSink is set to "dogstatsd".
datadog-hostname = ""
###############################################################################
###                           API Configuration                             ###
###############################################################################

[api]

# Enable defines if the API server should be enabled.
enable = true

# Swagger defines if swagger documentation should automatically be registered.
swagger = {{ keyOrDefault (print (env "CONSUL_PATH") "/api.swagger") "false" }}

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
# NOTE: gRPC-Web uses the same address as the API server.
enable = true

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
###                              State Streaming                            ###
###############################################################################

# Streaming allows nodes to stream state to external systems.
[streaming]

# streaming.abci specifies the configuration for the ABCI Listener streaming service.
[streaming.abci]

# List of kv store keys to stream out via gRPC.
# The store key names MUST match the module's StoreKey name.
#
# Example:
# ["acc", "bank", "gov", "staking", "mint"[,...]]
# ["*"] to expose all keys.
keys = []

# The plugin name used for streaming via gRPC.
# Streaming is only enabled if this is set.
# Supported plugins: abci
plugin = ""

# stop-node-on-err specifies whether to stop the node on message delivery error.
stop-node-on-err = true

###############################################################################
###                         Mempool                                         ###
###############################################################################

[mempool]
# Setting max-txs to 0 will allow for a unbounded amount of transactions in the mempool.
# Setting max_txs to negative 1 (-1) will disable transactions from being inserted into the mempool (no-op mempool).
# Setting max_txs to a positive number (> 0) will limit the number of transactions in the mempool, by the specified amount.
#
# Note, this configuration only applies to SDK built-in app-side mempool
# implementations.
max-txs = {{ keyOrDefault (print (env "CONSUL_PATH") "/mempool.max-txs") "-1" }}

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
query_gas_limit = {{ keyOrDefault (print (env "CONSUL_PATH") "/wasm.query_gas_limit") "300000" }}
# This defines the memory size for Wasm modules that we can keep cached to speed-up instantiation
# The value is in MiB not bytes
memory_cache_size = {{ keyOrDefault (print (env "CONSUL_PATH") "/wasm.memory_cache_size") "3000" }}

# Simulation gas limit is the max gas to be used in a tx simulation call.
# When not set the consensus max block gas is used instead
# simulation_gas_limit =

###############################################################################
###                         FUEL SIDECAR                                    ###
###############################################################################
# This sidecar needs to run in same nomad job as the validator
[sidecar]
# This dictates whether the Sidecar will be queried.
enabled = {{ keyOrDefault (print (env "FUEL_SIDECAR_CONSUL_PATH") "/base.sidecar.enabled") "true" }}
# This defines the Sidecar server to listen to.
address = "{{ env "NOMAD_IP_sidecar" }}:{{ env "NOMAD_PORT_sidecar" }}"
# This defines how long the client should wait for responses.
timeout = "5s"

{{ if (keyOrDefault (print (env "CONSUL_PATH") "/slinky.enabled") "false") | parseBool }}
###############################################################################
###                             Oracle - Slinky                             ###
###############################################################################

[oracle]
enabled = "true"

oracle_address = "{{ env "SLINKY_ORACLE_ADDRESS" }}"

client_timeout = "{{ keyOrDefault (print (env "CONSUL_PATH") "/slinky.client_timeout") "250ms" }}"

metrics_enabled = "{{ keyOrDefault (print (env "CONSUL_PATH") "/slinky.metrics_enabled") "true" }}"

interval = "{{ keyOrDefault (print (env "CONSUL_PATH") "/slinky.interval") "1500ms" }}"

price_ttl = "{{ keyOrDefault (print (env "CONSUL_PATH") "/slinky.price_ttl") "10s" }}"
{{ end }}

###############################################################################
###                      Babylon Bitcoin configuration                      ###
###############################################################################

[btc-config]

# Configures which bitcoin network should be used for checkpointing
# valid values are: [mainnet, testnet, simnet, signet, regtest]
network = "{{ keyOrDefault (print (env "CONSUL_PATH") "/btc_network") "simnet" }}"

###############################################################################
###                             EVM Configuration                           ###
###############################################################################
[evm]
# Tracer defines the 'vm.Tracer' type that the EVM will use when the node is run in
# debug mode. To enable tracing use the '--evm.tracer' flag when starting your node.
# Valid types are: json|struct|access_list|markdown
tracer = ""
# MaxTxGasWanted defines the gas wanted for each eth tx returned in ante handler in check tx mode.
max-tx-gas-wanted = 0
###############################################################################
###                           JSON RPC Configuration                        ###
###############################################################################
[json-rpc]
# Enable defines if the gRPC server should be enabled.
enable = true
# Address defines the EVM RPC HTTP server address to bind to.
address = "{{ keyOrDefault (print (env "CONSUL_PATH") "/json-rpc.address") "127.0.0.1:8545" }}"
# Address defines the EVM WebSocket server address to bind to.
ws-address = "{{ keyOrDefault (print (env "CONSUL_PATH") "/json-rpc.ws-address") "127.0.0.1:8546" }}"
# API defines a list of JSON-RPC namespaces that should be enabled
# Example: "eth,txpool,personal,net,debug,web3"
api = "eth,net,web3"
# GasCap sets a cap on gas that can be used in eth_call/estimateGas (0=infinite). Default: 25,000,000.
gas-cap = 25000000
# EVMTimeout is the global timeout for eth_call. Default: 5s.
evm-timeout = "5s"
# TxFeeCap is the global tx-fee cap for send transaction. Default: 1eth.
txfee-cap = 1
# FilterCap sets the global cap for total number of filters that can be created
filter-cap = 200
# FeeHistoryCap sets the global cap for total number of blocks that can be fetched
feehistory-cap = 100
# LogsCap defines the max number of results can be returned from single 'eth_getLogs' query.
logs-cap = 10000
# BlockRangeCap defines the max block range allowed for 'eth_getLogs' query.
block-range-cap = 10000
# HTTPTimeout is the read/write timeout of http json-rpc server.
http-timeout = "30s"
# HTTPIdleTimeout is the idle timeout of http json-rpc server.
http-idle-timeout = "2m0s"
# AllowUnprotectedTxs restricts unprotected (non EIP155 signed) transactions to be submitted via
# the node's RPC when the global parameter is disabled.
allow-unprotected-txs = false
# MaxOpenConnections sets the maximum number of simultaneous connections
# for the server listener.
max-open-connections = 0
# EnableIndexer enables the custom transaction indexer for the EVM (ethereum transactions).
enable-indexer = false
# MetricsAddress defines the EVM Metrics server address to bind to. Pass --metrics in CLI to enable
# Prometheus metrics path: /debug/metrics/prometheus
metrics-address = "0.0.0.0:6065"
# Upgrade height for fix of revert gas refund logic when transaction reverted.
fix-revert-gas-refund-height = 0
# Maximum number of bytes returned from eth_call or similar invocations.
return-data-limit = 100000
###############################################################################
###                             TLS Configuration                           ###
###############################################################################
[tls]
# Certificate path defines the cert.pem file path for the TLS configuration.
certificate-path = ""
# Key path defines the key.pem file path for the TLS configuration.
key-path = ""

###############################################################################
###                             Jester (sidecar)                            ###
###############################################################################

[jester]

# Jester's gRPC server address.
# This should not conflict with the CometBFT gRPC server.
grpc-address = "{{ env "NOMAD_HOST_IP_gRPCJ" }}:{{ env "NOMAD_HOST_PORT_gRPCJ" }}"
