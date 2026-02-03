enabled: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/sidecar.enabled") "true" }}
grpc_port: {{ env "NOMAD_PORT_grpcS" }}
zrchain_rpc: "{{ env "NOMAD_HOST_IP_grpc" }}:{{ env "NOMAD_HOST_PORT_grpc" }}"
state_file: "/home/zenrock/.zrchain/sidecar/cache.json"
operator_config: "/home/zenrock/.zrchain/sidecar/eigen_operator_config.yaml"
network: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/eth.network") "\"mainnet\"" }}
eth_rpc:
  testnet: "{{ with secret "static_secrets/ethereum/alchemy" }}{{ .Data.data.eth_holesky }}{{ end }}"
  mainnet: "{{ with secret "static_secrets/ankr" }}{{ .Data.data.eth_mainnet }}{{ end }}"
solana_rpc:
  testnet: {{ with secret "static_secrets/alchemy" }}{{ .Data.data.solana_testnet_rpc }}{{ end }}
  mainnet: {{ with secret "static_secrets/alchemy" }}{{ .Data.data.solana_mainnet_rpc }}{{ end }}
neutrino:
  path: "/home/zenrock/.zrchain/neutrino"
cipherowl:
  oauth_url: "https://cipherowl-prod.us.auth0.com/oauth/token"
  client_id: "{{ with secret "static_secrets/zenrock" }}{{ .Data.data.client_id }}{{end }}"
  client_secret: "{{ with secret "static_secrets/zenrock" }}{{ .Data.data.client_secret }}{{end }}"
  sanctions_url: "https://api.cipherowl.ai/api/v1/sanction/batch"
zcash_rpc:
  mainnet: "http://65.21.67.137:8232/"
