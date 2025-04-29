enabled: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/sidecar.enabled") "true" }}
grpc_port: {{ env "NOMAD_PORT_grpcS" }}
zrchain_rpc: "0.0.0.0:{{ env "NOMAD_PORT_zrpc" }}"
state_file: "cache.json"
operator_config: "/home/zenrock/.zrchain/sidecar/eigen_operator_config.yaml"
network: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/eth.network") "\"mainnet\"" }}
eth_rpc:
  local: "http://127.0.0.1:8545"
  testnet: "{{ with secret "static_secrets/ethereum/alchemy" }}{{ .Data.data.eth_holesky }}{{ end }}"
  mainnet: "{{ with secret "static_secrets/ethereum/alchemy" }}{{ .Data.data.eth_mainnet }}{{ end }}"
solana_rpc:
  testnet: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/solana_rpc.testnet") "\"\"" }}
  mainnet: "https://api.mainnet-beta.solana.com/"
neutrino:
  path: "/home/zenrock/.zrchain/neutrino"
proxy_rpc:
  url: ""
  user: ""
  password: ""
