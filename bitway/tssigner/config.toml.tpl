{{ with secret "static_secrets/side-protocol-tss" -}}
port = {{ keyOrDefault  (print (env "CONSUL_PATH") "/port") "5158" }}
enable_rpc = false
rpc_address = "127.0.0.1:6780"
[{{ keyOrDefault  (print (env "CONSUL_PATH") "/bootstrap.nodes") "" }}]
max_peers = 10
log_level = {{ keyOrDefault  (print (env "CONSUL_PATH") "/base.log_level") "\"debug\"" }}
mnemonic = "{{- .Data.data.mnemonic -}}"
priv_validator_key_path = "/home/tssigner/.shuttler/priv_validator_key.json"
relay_runes = false
last_scanned_height_bitway = 3226000
last_scanned_height_bitcoin = 912840
loop_interval = 60
batch_relayer_count = 10
max_attempts = 5

[bitcoin]
network = "bitcoin"
rpc = "http://192.248.150.102:18332"
user = "side"
password = "12345678"

[bitway]
grpc = {{ keyOrDefault  (print (env "CONSUL_PATH") "/sidechain.grpc") "\"\"" }}
rpc = {{ keyOrDefault  (print (env "CONSUL_PATH") "/sidechain.rpc") "\"\"" }}
gas = 1000000

[bitway.fee]
amount = 1000
denom = "ubtw"

[ordinals]
endpoint = ""

[fee_provider]
submit_fee_rate = false
fetch_fee_rate_url = "https://mempool.space/testnet/api/v1/fees/recommended"
