# This is a TOML config file.
# For more information, see https://github.com/toml-lang/toml

# The version of the Story binary that created or
# last modified the config file. Do not modify this.
version = "v0.12.1"

# Story network to participate in: mainnet, testnet, or devnet.
network = "{{ keyOrDefault (print "networks/" (index (env "CONSUL_PATH" | split "/") 1) "/base.network") "odyssey" }}"

#######################################################################
###                          Story Options                          ###
#######################################################################

# Story execution client Engine API http endpoint.
engine-endpoint = "http://{{ env NOMAD_IP_rpcG }}:{{ env NOMAD_PORT_rpcG}}"

# Story execution client JWT file used for authentication.
engine-jwt-file = "/home/story/.story/geth/odyssey/geth/jwtsecret"

# SnapshotInterval specifies the height interval at which story
# will take state sync snapshots. Defaults to 1000 (roughly once an hour), setting this to
# 0 disables state snapshots.
snapshot-interval = {{ keyOrDefault (print (env "CONSUL_PATH") "/statesync.snapshot-interval") "1000" }}

# snapshot-keep-recent specifies the number of recent snapshots to keep and serve (0 to keep all).
snapshot-keep-recent = {{ keyOrDefault (print (env "CONSUL_PATH") "/statesync.snapshot-keep-recent") "2" }}

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
min-retain-blocks = 0

# default: the last 72000 states are kept, pruning at 10 block intervals
# nothing: all historic states will be saved, nothing will be deleted (i.e. archiving node)
# everything: 2 latest states will be kept; pruning at 10 block intervals.
pruning = {{ keyOrDefault (print (env "CONSUL_PATH") "/base.pruning") "\"default\"" }}

# AppDBBackend defines the database backend type to use for the application and snapshots DBs.
# An empty string indicates that a fallback will be used.
# The fallback is the db_backend value set in CometBFT's config.toml.
app-db-backend = "goleveldb"

# EVMBuildDelay defines the minimum delay between triggering a EVM payload build and fetching the result.
# This is a tradeoff between "high value blocks" and "fast consensus".
# It should be slightly higher than geth's --miner.recommit value.
evm-build-delay = "600ms"

# EVMBuildOptimistic defines whether to trigger optimistic EVM payload building.
# If true, the EVM payload will be triggered on previous finalisation. This allows
# more time for block building while ensuring faster consensus blocks.
evm-build-optimistic = false

# APIEnable defines if the API server should be enabled.
api-enable = false

# APIAddress defines the API server address to listen on.
api-address = "0.0.0.0:1317"

# EnableUnsafeCORS defines whether to enable CORS for API server.
enabled-unsafe-cors = false

#######################################################################
###                         Logging Options                         ###
#######################################################################

[log]
# Logging level. Note cometBFT internal logs are configured in config.yaml.
# Options are: debug, info, warn, error.
level = {{ keyOrDefault  (print (env "CONSUL_PATH") "/base.log_level") "\"info\"" }}

# Logging format. Options are: console, json.
format = {{ keyOrDefault  (print (env "CONSUL_PATH") "/base.log_format") "\"json\"" }}

# Logging color if console format is chosen. Options are: auto, force, disable.
color = "auto"

[tracing]
# Open Telemetry OTLP endpoint URL. See https://pkg.go.dev/go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracehttp.
endpoint = "{{ keyOrDefault  (print (env "CONSUL_PATH") "/metrics.otel") "" }}"

# Open Telemetry OTLP headers. See https://grafana.com/docs/grafana-cloud/monitor-applications/application-observability/setup/quickstart/go/.
headers = ""
