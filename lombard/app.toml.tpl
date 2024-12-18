###############################################################################
###                         Notaryd                                         ###
###############################################################################

{{- with secret "static_secrets/lombard-testnet" }}
[bitcoin]
host = "{{ .Data.data.btc_signet_rpc }}" # replace by your own without http/https
user = "1" # if your endpoint does not require authentication keep some dummy values in these fields
pass = "1"
params = "{{ keyOrDefault (print (env "CONSUL_PATH") "/btc_network") "mainnet" }}"
disable_tls = false # set true if http
required_confirmations = 6
      
[evm.holesky]
rpc_url = "{{ .Data.data.eth_holesky_rpc }}" # replace by your own
chain_id = "0x4268"
required_confirmations = 65
enabled = true
      
[evm.bsc_testnet]
rpc_url = "{{ .Data.data.bsc_testnet_chapel_rpc }}" # replace by your own
chain_id = "0x61"
required_confirmations = 15
enabled = true
      
[evm.base_sepolia]
rpc_url = "{{ .Data.data.base_sepolia_rpc }}" # replace by your own
chain_id = "0x014a34"
required_confirmations = 72
enabled = true
{{ end -}}
