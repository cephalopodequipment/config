{{ with secret "static_secrets/side-testnet" -}}
p2p_keypair = "{{- .Data.data.keypair -}}"
port = 5158
bootstrap_nodes = [{{ keyOrDefault  (print (env "CONSUL_PATH") "/bootstrap.nodes") "\"\"" }}]
log_level = "info"
mnemonic = "{{- .Data.data.mnemonic -}}"
priv_validator_key_path = {{ keyOrDefault  (print (env "CONSUL_PATH") "/validator.priv_validator_key_path") "\"\"" }}
relay_runes = false
last_scanned_height = 0
loop_interval = 60
batch_relayer_count = 10

[bitcoin]
network = "testnet"
rpc = "http://192.248.150.102:18332"
user = "{{- .Data.data.bitcoinuser -}}"
password = "{{- .Data.data.bitcoinpassword -}}"

[side_chain]
grpc = "http://10.20.30.106:22183"
gas = 200000

[side_chain.fee]
amount = 1000
denom = "uside"

[ordinals]
endpoint = ""

[oracle]
submit_fee_rate = false
submit_fee_rate_interval = 60
fetch_fee_rate_url = "https://mempool.space/testnet/api/v1/fees/recommended"
{{- end -}}