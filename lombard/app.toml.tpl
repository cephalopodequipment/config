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
timeout = "10s"

[evm.avalanche_fuji]
rpc_url = "https://avalanche-fuji-c-chain-rpc.publicnode.com" # replace by your own
chain_id = "0xa869"
required_confirmations = 20
enabled = true
      
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

[evm.sepolia]
rpc_url = "https://ethereum-sepolia-rpc.publicnode.com" # can use this or replace with your own
chain_id = "0xaa36a7"
required_confirmations = 64
enabled = true

[starknet.sepolia]
chain_id = "SN_SEPOLIA"
rpc_url = "{{ .Data.data.starknet_sepolia_drpc }}"
timeout = "10s"

[evm.sonic_testnet]
rpc_url = "{{ .Data.data.sonic_testnet_rpc }}"  # replace by your own
chain_id = "0xdede"
required_confirmations = 1
enabled = true

[evm.ink_sepolia]
rpc_url = "{{ .Data.data.ink_sepolia_rpc }}" # replace by your own
chain_id = "0x0ba5ed"
required_confirmations = 1800
enabled = true

[evm.katana_testnet]
rpc_url = "https://rpc.tatara.katanarpc.com/6Kx2yUoN5AXEZe68PSdPgMPZQtZStLy7m"
chain_id = "0x1F977"
required_confirmations = 3600
enabled = true

[katana]
chain_id = "0x000000000000000000000000000000000000000000000000000000000001F977"
native_lbtc_address = "0x20eA7b8ABb4B583788F1DFC738C709a2d9675681"

[blacklist]
rpc_url = "{{ .Data.data.base_sepolia_rpc }}" # replace with your base sepolia rpc
contract = "0xe705037ce9a9ca7859ee15d04a569783da7121c8"

[sui.testnet] # for testnet
chain_id = "0x4c78adac"
rpc_url = "{{ .Data.data.sui_testnet_rpc }}" # replace by your own
package_id = "0x50454d0b0fbad1288a6ab74f2e8ce0905a3317870673ab7787ebcf6f322b45fa"

[solana.devnet]
rpc_url = "{{ .Data.data.solana_devnet }}" # replace by your own
genesis_hash = "EtWTRABZaYq6iMfeYKouRu166VU2xqa1wcaWoxPkrZBG"

{{ end -}}

[cosmos.ledger_mainet] # for mainnet
rpc_url = "{{ range service "lombard-mainnet-validator.cometbft-rpc" }}http://{{ .Address }}:{{ .Port }}{{ end }}"
chain_id = "ledger-mainnet-1"
enabled = {{ keyOrDefault (print (env "CONSUL_PATH") "/cosmos_ledger_mainnet_enabled") "false" }}

[cosmos.ledger_testnet] # for testnet
rpc_url = "{{ range service "lombard-testnet-validator.cometbft-rpc" }}http://{{ .Address }}:{{ .Port }}{{ end }}"
chain_id = "ledger-testnet-1"
enabled = {{ keyOrDefault (print (env "CONSUL_PATH") "/cosmos_ledger_testnet_enabled") "false" }}

[sanctions]
url = "https://staging.prod.lombard-fi.com/"
