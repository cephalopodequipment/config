{{ with secret "static_secrets/side-protocol-tss" -}}
port = {{ keyOrDefault  (print (env "CONSUL_PATH") "/port") "5158" }}
bootstrap_nodes = [{{ keyOrDefault  (print (env "CONSUL_PATH") "/bootstrap.nodes") "" }}]
log_level = {{ keyOrDefault  (print (env "CONSUL_PATH") "/base.log_level") "\"info\"" }}
mnemonic = "{{- .Data.data.mnemonic -}}"
priv_validator_key_path = {{ keyOrDefault  (print (env "CONSUL_PATH") "/validator.priv_validator_key_path") "\"\"" }}
relay_runes = false
last_scanned_height = 0
loop_interval = 60
batch_relayer_count = 10
max_attempts = 5

[bitcoin]
network = {{ keyOrDefault  (print (env "CONSUL_PATH") "/bitcoin.network") "\"bitcoin\"" }}
rpc = {{ keyOrDefault  (print (env "CONSUL_PATH") "/bitcoin.rpc") "\"\"" }}
user = "{{- .Data.data.bitcoinuser -}}"
password = "{{- .Data.data.bitcoinpassword -}}"

[side_chain]
grpc = {{ keyOrDefault  (print (env "CONSUL_PATH") "/sidechain.grpc") "\"\"" }}
gas = 2000000

[side_chain.fee]
amount = 2000
denom = "uside"

[ordinals]
endpoint = ""

[oracle]
submit_fee_rate = false
fetch_fee_rate_url = "https://mempool.space/testnet/api/v1/fees/recommended"
{{- end -}}
