# bitcoin.conf file
server=1
# rpcauth - sets the rpcuser and rpcpassword so the password doesnt need 
# to be displayed in full text - these values are stored in vault.
# Use this tool https://jlopp.github.io/bitcoin-core-rpc-auth-generator/
# or use the python script here 
# https://github.com/bitcoin/bitcoin/blob/master/share/rpcauth/README.md
# to generate an rpcauth string
{{- with secret (printf "static_secrets/%s/%s" (env "SECRETS_PATH") (env "BTC_NODE_TYPE")) }}
rpcauth={{ .Data.data.rpcauth }}
{{- end}}
# rpc cookie file this allows authentication to only those that have access to the cookie location
rpccookiefile={{key (print (env "CONSUL_PATH") "/btc_home_dir")}}/.cookie
# txindex turns on transaction indexing values 0 = no tx indexing or 1 = tx indexing
txindex={{ env "BTC_TX_INDEX" }}
chain={{ key (print (env "CONSUL_PATH") "/chain_id")}}
[{{ key (print (env "CONSUL_PATH") "/chain_id")}}]
rpcbind=0.0.0.0
rpcallowip=0.0.0.0/0