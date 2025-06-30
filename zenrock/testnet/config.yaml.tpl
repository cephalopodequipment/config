enabled: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/sidecar.enabled") "true" }}
grpc_port: {{ env "NOMAD_PORT_grpcS" }}
zrchain_rpc: {{ env "NOMAD_ADDR_zrpc" }}
state_file: "/home/zenrock/.zrchain/sidecar/cache.json"
operator_config: "/home/zenrock/.zrchain/sidecar/eigen_operator_config.yaml"
network: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/eth.network") "\"mainnet\"" }}
eth_rpc:
  local: "http://127.0.0.1:8545"
  testnet: "{{ with secret "static_secrets/ethereum/alchemy" }}{{ .Data.data.eth_holesky }}{{ end }}"
  mainnet: "{{ with secret "static_secrets/ethereum/alchemy" }}{{ .Data.data.eth_mainnet }}{{ end }}"
solana_rpc:
  testnet: {{ with secret "static_secrets/alchemy" }}{{ .Data.data.solana_testnet_rpc }}{{ end }}
  mainnet: {{ with secret "static_secrets/alchemy" }}{{ .Data.data.solana_mainnet_rpc }}{{ end }}
neutrino:
  path: "/home/zenrock/.zrchain/neutrino"
proxy_rpc:
  url: "https://bitcoin-proxy.gardia.zenrocklabs.io"
  user: "zenrock"
  password: "{{ with secret "static_secrets/zenrock-gardia" }}{{ .Data.data.proxy_rpc_password }}{{end }}"
