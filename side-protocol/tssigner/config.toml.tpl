p2p_keypair = "{{ with secret "static_secrets/side-testnet/tssigner-p2p_keypair" -}}"
port = 5158
bootstrap_nodes = [{{ keyOrDefault  (print (env "TSSIGNER_CONSUL_PATH") "/bootstrap.nodes") "\"\/ip4/192.248.180.245/tcp/5158/p2p/12D3KooWMpMtmYQKSn1sZaSRn4CAcsraWZVrZ2zdNjEgsEPSd3Pv"" }}]
log_level = "info"
mnemonic = "{{ with secret "static_secrets/side-testnet/tssigner-key" -}}"
priv_validator_key_path = "{{ keyOrDefault  (print (env "TSSIGNER_CONSUL_PATH") "/validator.priv_validator_key_path") "\"\priv_validator_key.json"" }}"
relay_runes = false
last_scanned_height = 0
loop_interval = 60
batch_relayer_count = 10

[bitcoin]
network = "testnet"
rpc = "http://192.248.150.102:18332"
user = "side"
password = "12345678"

[side_chain]
grpc = "http://localhost:9090"
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
