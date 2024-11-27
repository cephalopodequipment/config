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
    service_manager: "0xa559CDb9e029fc4078170122eBf7A3e622a764E4"
    price_feed: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419"
    network_name: "Holešky Ethereum Testnet"
solana_rpc:
  testnet: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/solana_rpc.testnet") "\"\"" }}
  mainnet: ""
proxy_rpc:
  url: ""
  user: ""
  password: ""
neutrino:
  path: "home/zenrock/.zrchain/neutrino"