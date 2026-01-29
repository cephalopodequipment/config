enabled: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/sidecar.enabled") "true" }}
grpc_port: {{ env "NOMAD_PORT_grpcS" }}
zrchain_rpc: "{{ env "NOMAD_HOST_IP_grpc" }}:{{ env "NOMAD_HOST_PORT_grpc" }}"
state_file: "/home/zenrock/.zrchain/sidecar/cache.json"
operator_config: "/home/zenrock/.zrchain/sidecar/eigen_operator_config.yaml"
network: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/eth.network") "\"mainnet\"" }}
eth_rpc:
  local: "http://127.0.0.1:8545"
  testnet: "{{ with secret "static_secrets/ethereum/alchemy" }}{{ .Data.data.eth_holesky }}{{ end }}"
  mainnet: "{{ range service "eth-full-node3.geth-rpc" }}http://{{ .Address }}:{{ .Port }}{{ end }}"
solana_rpc:
  testnet: {{ with secret "static_secrets/alchemy" }}{{ .Data.data.solana_testnet_rpc }}{{ end }}
  mainnet: {{ with secret "static_secrets/alchemy" }}{{ .Data.data.solana_mainnet_rpc }}{{ end }}
neutrino:
  path: "/home/zenrock/.zrchain/neutrino"
cipherowl:
      oauth_url: "https://cipherowl-prod.us.auth0.com/oauth/token"
      client_id: "tlgs6tHCJbVvKEG5Bq5LxNu068tOe1vZ"
      client_secret: "W3yIqFOQ5SVlor-NPsXHv8jmEfPJ0rU5WXutFj3nAvFzBM7RpR_b84lv1KpOFYpf"
      sanctions_url: "https://api.cipherowl.ai/api/v1/sanction/batch"
zcash_rpc:
  testnet: "http://65.21.67.137:18232/"
proxy_rpc:
  url: "https://bitcoin-proxy.gardia.zenrocklabs.io"
  user: "zenrock"
  password: "{{ with secret "static_secrets/zenrock-gardia" }}{{ .Data.data.proxy_rpc_password }}{{end }}"
