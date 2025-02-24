###############################################################################
###                         Notaryd                                         ###
###############################################################################

{{- with secret "static_secrets/lombard-mainnet" }}
[blacklist]
rpc_url = "{{ .Data.data.base_rpc }}" # replace by your own
contract = "0xdf0D1818C5276aD63Ce73E20223657d4920E5e82"

[bitcoin]
host = "{{ .Data.data.btc_rpc }}" # replace by your own without http/https
user = "1" # if your endpoint does not require authentication keep some dummy values in these fields
pass = "1"
params = "mainnet"
disable_tls = false # set true if http
required_confirmations = 6

[evm.mainnet]
rpc_url = "{{ .Data.data.eth_rpc }}" # replace by your own
chain_id = "0x01"
required_confirmations = 65
enabled = true

[evm.bsc]
rpc_url = "{{ .Data.data.bsc_rpc }}" # replace by your own
chain_id = "0x38"
required_confirmations = 15
enabled = true

[evm.base]
rpc_url = "{{ .Data.data.base_rpc }}" # replace by your own
chain_id = "0x2105"
required_confirmations = 72
enabled = true

[sui.mainnet]
chain_id = "0x35834a8a"
rpc_url = "{{ .Data.data.sui_rpc }}" # replace by your own
package_id = "0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040"

[sanctions]
url = "https://mainnet.prod.lombard.finance/"

[evm.sepolia]
enabled = false

[evm.holesky]
enabled = false
{{ end -}}
