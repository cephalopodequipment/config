grpc_port: {{ env "NOMAD_PORT_grpcS" }}
state_file: {{ keyOrDefault  (print (env "CONSUL_PATH") "/state.file") "\"cache.json\"" }}
operator_config: {{ keyOrDefault  (print (env "CONSUL_PATH") "/state.file") "\".zrchain/sidecar/eigen_operator_config.yaml\"" }}
eth_oracle:
  rpc:
    local: {{ keyOrDefault  (print (env "CONSUL_PATH") "/state.file") "\"http://127.0.0.1:8545\"" }}
    testnet: {{ keyOrDefault  (print (env "CONSUL_PATH") "/rpc.testnet") "\"\"" }}
    mainnet: {{ keyOrDefault  (print (env "CONSUL_PATH") "/rpc.mainnet") "\"\"" }}
  network: {{ keyOrDefault  (print (env "CONSUL_PATH") "/eth.network") "\"testnet\"" }}
  contract_addrs:
    service_manager: "0xb48F00b89A4017f78794F35cb1ef540EDA5d201B"
    price_feed: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419"
    network_name: "Holešky Ethereum Testnet"
