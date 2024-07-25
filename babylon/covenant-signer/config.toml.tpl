# There are two btc related configs
# 1. [btc-config] is config for btc full node which should have transaction indexing
# enabled. This node should be synced and can be open to the public.
# 2. [btc-signer-config] is config for bitcoind daemon which should have only
# wallet functionality, it should run in separate network. This bitcoind instance
# will be used to sign psbt's
[btc-config]
# Btc node host
# N.B Assumes only 1 node is running as a Full tx node on the specified btc chain (main, signet)
{{- range service "bitcoin-rpc" }}
{{- if .Tags | contains (env "BTC_CHAIN") }}
{{- if .Tags | contains "fullnode" }}
host = "{{ .Address }}:{{ .Port }}"
{{- end }}
{{- end }}
{{- end }}
{{- with secret (printf "static_secrets/%s/fullnode" (env "SECRETS_PATH")) }}
# Btc node user
user = "{{ .Data.data.rpcuser }}"
# Btc node password
pass =  "{{ .Data.data.rpcpassword }}"
{{- end }}
# Btc network (testnet3|mainnet|regtest|simnet|signet)
network = "{{ env "BTC_CHAIN" }}"

[btc-signer-config]
# Btc Signer/Wallet node
# N.B Assumes only 1 node is running as a wallet node on the specified btc chain (main, signet)
{{- range service "bitcoin-wallet-rpc" }}
{{- if .Tags | contains (env "BTC_CHAIN") }}
{{- if .Tags | contains "signer-node" }}
host = "{{ .Address }}:{{ .Port }}"
{{- end }}
{{- end }}
{{- end }}
# TODO: consider reading user/pass from command line
{{- with secret (printf "static_secrets/%s/signer-node" (env "SECRETS_PATH")) }}
# Btc node user
user =  "{{ .Data.data.rpcuser }}"
# Btc node password
pass =  "{{ .Data.data.rpcpassword }}"
{{- end }}
# Btc network (testnet3|mainnet|regtest|simnet|signet)
network = "{{ env "COVENANT_NETWORK" }}"

[server-config]
# The address to listen on
host = "0.0.0.0"

# The port to listen on
port = 31530

# Read timeout in seconds
read-timeout = 15

# Write timeout in seconds
write-timeout = 15

# Idle timeout in seconds
idle-timeout = 120

#### Parameters related to the Prometheus metrics server
[metrics]
# The prometheus server host
host = "0.0.0.0"
# The prometheus server port
port = "{{ env "NOMAD_PORT_prom" }}"
