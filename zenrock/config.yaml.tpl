grpc_port: {{ env "NOMAD_PORT_grpcS" }}
state_file: "cache.json"
operator_config: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/operator.config") "\"\"" }}
network: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/eth.network") "\"testnet\"" }}
eth_oracle:
  rpc:
    local: "http://127.0.0.1:8545"
    {{- with secret "static_secrets/ankr" }}
    testnet: "{{ .Data.data.holesky_endpoint }}"
    {{- end -}}{{ with secret "static_secrets/alchemy" }}
    mainnet: "{{ .Data.data.eth_endpoint }}"
    {{- end }}
  contract_addrs:
    service_manager: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/config.service_manager") "\"\"" }}
    price_feed: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/config.price_feed") "\"\"" }}
    network_name: "Holešky Ethereum Testnet"
solana_rpc:
  testnet: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/solana_rpc.testnet") "\"\"" }}
  mainnet: ""
proxy_rpc:
  url: ""
  user: ""
  password: ""
neutrino:
  path: "/home/zenrock/.zrchain/neutrino"
