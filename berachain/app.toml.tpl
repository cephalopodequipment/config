# This is a TOML config file.
# For more information, see https://github.com/toml-lang/toml

###############################################################################
###                           Base Configuration                            ###
###############################################################################

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
# Note: CometBFT block pruning is dependent on this parameter in conjunction
# with the unbonding (safety threshold) period, state pruning and state sync
# snapshot parameters to determine the correct minimum value of
# ResponseCommit.RetainHeight.
min-retain-blocks = {{ keyOrDefault (print (env "CONSUL_PATH") "/base.min-retain-blocks") "0" }}

# InterBlockCache enables inter-block caching.
inter-block-cache = true

# IavlCacheSize set the size of the iavl tree cache (in number of nodes).
iavl-cache-size = {{ keyOrDefault (print (env "CONSUL_PATH") "/base.iavl-cache-size") "2500" }}

# IAVLDisableFastNode enables or disables the fast node feature of IAVL. 
# Default is false.
iavl-disable-fastnode = {{ keyOrDefault (print (env "CONSUL_PATH") "/base.iavl-disable-fastnode") "true" }}


###############################################################################
###                         Telemetry Configuration                         ###
###############################################################################

[telemetry]

# Prefixed with keys to separate services.
service-name = ""

# Enabled enables the application telemetry functionality. When enabled,
# an in-memory sink is also enabled by default. Operators may also enabled
# other sinks such as Prometheus.
enabled = {{ keyOrDefault (print (env "CONSUL_PATH") "/telemetry.enabled") "true" }}

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
###                                BeaconKit                                ###
###############################################################################

[beacon-kit.engine]
# HTTP url of the execution client JSON-RPC endpoint.
rpc-dial-url = "http://localhost:8551"

# Number of retries before shutting down consensus client.
rpc-retries = "3"

# RPC timeout for execution client requests.
rpc-timeout = "900ms"

# Interval for the startup check.
rpc-startup-check-interval = "3s"

# Interval for the JWT refresh.
rpc-jwt-refresh-interval = "30s"

# Path to the execution client JWT-secret
jwt-secret-path = "/home/beacond/jwt.hex"

[beacon-kit.logger]
# TimeFormat is a string that defines the format of the time in the logger.
time-format = "RFC3339"

# LogLevel is the level of logging. Logger will log messages with verbosity up
# to LogLevel.
log-level = "info"

# Style is the style of the logger.
style = "pretty"

[beacon-kit.kzg]
# Path to the trusted setup path.
trusted-setup-path = "/home/beacond/testing/files/kzg-trusted-setup.json"

# KZG implementation to use.
# Options are "crate-crypto/go-kzg-4844" or "ethereum/c-kzg-4844".
implementation = "crate-crypto/go-kzg-4844"

[beacon-kit.payload-builder]
# Enabled determines if the local payload builder is enabled.
# It should be enabled for validators, but it can be disabled
# for full nodes.
enabled = true

# Post bellatrix, this address will receive the transaction fees produced by any blocks
# from this node.
suggested-fee-recipient = {{ key (print (env "CONSUL_PATH") "/beacon-kit.payload-builder.suggested-fee-recipient") }}

# The timeout for local build payload. This should match, or be slightly less
# than the configured timeout on your execution client. It also must be less than
# timeout_proposal in the CometBFT configuration.
payload-timeout = "850ms"

[beacon-kit.validator]
# Graffiti string that will be included in the graffiti field of the beacon block.
graffiti = {{ keyOrDefault (print (env "CONSUL_PATH") "/beacon-kit.validator.graffiti") "\"\"" }}

# EnableOptimisticPayloadBuilds enables building the next block's payload optimistically in
# process-proposal to allow for the execution client to have more time to assemble the block.
enable-optimistic-payload-builds = "true"

[beacon-kit.block-store-service]
# Enabled determines if the block store service is enabled.
enabled = {{ keyOrDefault (print (env "CONSUL_PATH") "/beacon-kit.block-store-service.enabled") "\"false\"" }}

# AvailabilityWindow is the number of slots to keep in the store.
availability-window = "8192"

[beacon-kit.node-api]
# Enabled determines if the node API is enabled.
enabled = {{ keyOrDefault (print (env "CONSUL_PATH") "/beacon-kit.node-api.enabled") "\"true\"" }}

# Address is the address to bind the node API to.
address = {{ keyOrDefault (print (env "CONSUL_PATH") "/beacon-kit.node-api.address") "\"0.0.0.0:3500\"" }}

# Logging determines if the node API logging is enabled.
logging = {{ keyOrDefault (print (env "CONSUL_PATH") "/beacon-kit.node-api.logging") "\"false\"" }}

[beacon-kit]
# required for bectra upgrade
chain-spec = "mainnet"
