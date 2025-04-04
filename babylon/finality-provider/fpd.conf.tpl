[Application Options]
; Logging level for all subsystems
LogLevel = {{ keyOrDefault (print (env "CONSUL_PATH") "/LogLevel") "info" }}

; the type of the consumer chain
ChainType = {{ keyOrDefault (print "networks/" (index (env "CONSUL_PATH" | split "/") 1) "/ChainType") "babylon" }}

; The number of Schnorr public randomness for each commitment
NumPubRand = {{ keyOrDefault (print (env "CONSUL_PATH") "/NumPubRand") "70000" }}

; The upper bound of the number of Schnorr public randomness for each commitment
# NumPubRandMax = {{ keyOrDefault (print (env "CONSUL_PATH") "/NumPubRandMax") "100000" }}

; The delay, measured in blocks, between a randomness commit submission and the randomness is BTC-timestamped
TimestampingDelayBlocks = {{ keyOrDefault (print (env "CONSUL_PATH") "/TimestampingDelayBlocks") "6000" }}

; The maximum number of retries to submit finality signature or public randomness
MaxSubmissionRetries = {{ keyOrDefault (print (env "CONSUL_PATH") "/MaxSubmissionRetries") "20" }}

; The address of the remote EOTS manager; Empty if the EOTS manager is running locally
EOTSManagerAddress = {{ env "NOMAD_HOST_IP_eotsdrpc" }}:{{ env "NOMAD_HOST_PORT_eotsdrpc" }}

; The size of a batch in one submission
BatchSubmissionSize = {{ keyOrDefault (print (env "CONSUL_PATH") "/BatchSubmissionSize") "1000" }}

; The interval between each attempt to commit public randomness
RandomnessCommitInterval = {{ keyOrDefault (print (env "CONSUL_PATH") "/RandomnessCommitInterval") "30s" }}

; The interval between each attempt to submit finality signature or public randomness after a failure
SubmissionRetryInterval = {{ keyOrDefault (print (env "CONSUL_PATH") "/SubmissionRetryInterval") "1s" }}

; The interval between each finality signature(s) submission
SignatureSubmissionInterval = {{ keyOrDefault (print (env "CONSUL_PATH") "/SignatureSubmissionInterval") "1s" }}

; Bitcoin network to run on
BitcoinNetwork = {{ keyOrDefault (print (env "CONSUL_PATH") "/BitcoinNetwork") "signet" }}

; the listener for RPC connections, e.g., 127.0.0.1:1234
RPCListener = 0.0.0.0:12581

[chainpollerconfig]
; The maximum number of Babylon blocks that can be stored in the buffer
BufferSize = 1000

; The interval between each polling of blocks; the value should be set depending on the block production time but could be set smaller for quick catching up
PollInterval = 1s

; The poll batch size when polling for blocks
PollSize = 1000

; The static height from which we start polling the chain
StaticChainScanningStartHeight = 1

; Automatically discover the height from which to start polling the chain
AutoChainScanningMode = true

[dbconfig]
; The directory path in which the database file should be stored.
DBPath = /home/fpd/.fpd/data

; The name of the database file.
DBFileName = finality-provider.db

; Prevents the database from syncing its freelist to disk, resulting in improved performance at the expense of increased startup time.
NoFreelistSync = true

; Specifies if a Bolt based database backend should be automatically compacted on startup (if the minimum age of the database file is reached). This will require additional disk space for the compacted copy of the database but will result in an overall lower database size after the compaction.
AutoCompact = false

; Specifies the minimum time that must have passed since a bolt database file was last compacted for the compaction to be considered again.
AutoCompactMinAge = 168h0m0s

; Specifies the timeout value to use when opening the wallet database.
DBTimeout = 1m0s

[babylon]
; name of the key to sign transactions with
Key = {{ key (print (env "CONSUL_PATH") "/fpd.wallet_key_name") }}

; chain id of the chain to connect to
ChainID = {{ key (print "networks/" (index (env "CONSUL_PATH" | split "/") 1) "/base.chain_id") }}


{{ $connected_fullnode_servicename := (key (print (env "CONSUL_PATH") "/connected_fullnode_servicename")) }}
{{ $chain_id := (key (print "networks/" (index (env "CONSUL_PATH" | split "/") 1) "/base.chain_id")) }}

; address of the rpc server to connect to
RPCAddr = {{ range service (printf "%s-%s.cometbft-rpc" $chain_id $connected_fullnode_servicename) }}http://{{ .Address }}:{{ .Port }}{{ end }}

; address of the grpc server to connect to
GRPCAddr = {{ range service (printf "%s-%s.cosmos-sdk-grpc" $chain_id $connected_fullnode_servicename) }}http://{{ .Address }}:{{ .Port }}{{ end }}

; account prefix to use for addresses
AccountPrefix = bbn

; type of keyring to use
KeyringBackend = {{ keyOrDefault (print (env "CONSUL_PATH") "/keyring.backend") "test" }}

; adjustment factor when using gas estimation
GasAdjustment = 1.5

; comma separated minimum gas prices to accept for transactions
GasPrices = {{ keyOrDefault (print (env "CONSUL_PATH") "/base.minimum-gas-price") "0.002ubbn" }}

; directory to store keys in
KeyDirectory = /home/fpd/.fpd

; flag to print debug output
Debug = true

; client timeout when doing queries
Timeout = 20s

; block timeout when waiting for block events
BlockTimeout = 1m0s

; default output when printint responses
OutputFormat = json

; sign mode to use
SignModeStr = direct

[metrics]
; IP of the Prometheus server
Host = 0.0.0.0

; Port of the Prometheus server
Port = 2112

; The interval of Prometheus metrics updated
UpdateInterval = {{ keyOrDefault (print (env "CONSUL_PATH") "/prom.update_interval") "1000ms" }}
