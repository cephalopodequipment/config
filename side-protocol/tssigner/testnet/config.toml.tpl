{{ with secret "static_secrets/sidechain-testnet-6" -}}
# This block configures P2P and RPC settings for tssigner (shuttler).
#
# The RPC endpoint must be enabled in order to access metrics.
# Setting `enable_rpc` to `true` allows you to retrieve metrics from the `/metrics` endpoint.
port = {{ env "NOMAD_PORT_p2p" }}
enable_rpc = {{ keyOrDefault  (print (env "CONSUL_PATH") "/base.enable_rpc") "false" }}
rpc_address = "0.0.0.0:{{ env "NOMAD_PORT_rpc" }}"port = {{ env "NOMAD_PORT_p2p" }}
enable_rpc = {{ keyOrDefault  (print (env "CONSUL_PATH") "/base.enable_rpc") "false" }}
rpc_address = "0.0.0.0:{{ env "NOMAD_PORT_rpc" }}"

bootstrap_nodes = [{{ keyOrDefault  (print (env "CONSUL_PATH") "/bootstrap.nodes") "" }}]
log_level = {{ keyOrDefault  (print (env "CONSUL_PATH") "/base.log_level") "\"info\"" }}
mnemonic = "{{- .Data.data.tss_mnemonic -}}"
priv_validator_key_path = "/home/tssigner/.shuttler/priv_validator_key.json"
relay_runes = false
last_scanned_height_side = 0
last_scanned_height_bitcoin = 0
loop_interval = 60
batch_relayer_count = 10
max_attempts = 5

[bitcoin]
network = {{ keyOrDefault  (print (env "CONSUL_PATH") "/bitcoin.network") "\"bitcoin\"" }}
rpc = {{ keyOrDefault  (print (env "CONSUL_PATH") "/bitcoin.rpc") "\"\"" }}
user = "{{- .Data.data.bitcoinuser -}}"
password = "{{- .Data.data.bitcoinpassword -}}"

[side_chain]
grpc = "{{ range service "sidechain-testnet-6-validator.cosmos-sdk-grpc" }}http://{{ .Address }}:{{ .Port }}{{ end }}"
rpc = "{{ range service "sidechain-testnet-6-validator.cometbft-rpc" }}http://{{ .Address }}:{{ .Port }}{{ end }}"
gas = 1000000

[side_chain.fee]
amount = 1000
denom = "uside"

[ordinals]
endpoint = ""

[fee_provider]
submit_fee_rate = false
fetch_fee_rate_url = "https://mempool.space/testnet/api/v1/fees/recommended"
{{ end }}
