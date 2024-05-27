# There are two btc related configs
# 1. [btc-config] is config for btc full node which should have transaction indexing
# enabled. This node should be synced and can be open to the public.
# 2. [btc-signer-config] is config for bitcoind daemon which should have only
# wallet functionality, it should run in separate network. This bitcoind instance
# will be used to sign psbt's
[btc-config]
# Btc node host
{{- range service "bitcoin-rpc" "tag=fullnode" }}
host = "{{ .Address }}:{{ .Port }}"
{{- end }}
{{- with secret "static_secrets/babylon-testnet/btc-fullnode" }}
# Btc node user
user = "{{ .Data.data.rpcuser }}"
# Btc node password
pass =  "{{ .Data.data.rpcpassword }}"
{{- end }}
# Btc network (testnet3|mainnet|regtest|simnet|signet)
network = "{{ env "BTC_CHAIN" }}"

[btc-signer-config]
# Btc node host
{{- range service "bitcoin-rpc" "tag=signer-node"}}
host = "{{ .Address }}:{{ .Port }}"
{{- end }}
# TODO: consider reading user/pass from command line
{{- with secret "static_secrets/babylon-testnet/btc-signer" }}
# Btc node user
user =  "{{ .Data.data.rpcuser }}"
# Btc node password
pass =  "{{ .Data.data.rpcpassword }}"
{{- end }}
# Btc network (testnet3|mainnet|regtest|simnet|signet)
network = "{{ env "BTC_CHAIN" }}"

[server-config]
# The address to listen on
host = "0.0.0.0"

# The port to listen on
port = 32530

# Read timeout in seconds
read-timeout = 15

# Write timeout in seconds
write-timeout = 15

# Idle timeout in seconds
idle-timeout = 120