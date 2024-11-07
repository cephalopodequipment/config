{{- with secret "static_secrets/ankr" }}
grpc_port: {{ env "NOMAD_PORT_grpcS" }}
state_file: "cache.json"
operator_config: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/operator.config") "\"\"" }}
eth_oracle:
  rpc:
    local: "http://127.0.0.1:8545"
    testnet: {{ .Data.data.holesky_endpoint }}
    {{- end -}}{{ with secret "static_secrets/alchemy" }}
    mainnet: {{ .Data.data.eth_endpoint }}
    {{- end }}
  network: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/eth.network") "\"testnet\"" }}
  contract_addrs:
    service_manager: "0xb48F00b89A4017f78794F35cb1ef540EDA5d201B"
    price_feed: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419"
    network_name: "Holešky Ethereum Testnet"
