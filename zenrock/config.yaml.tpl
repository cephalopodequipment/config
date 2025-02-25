enabled: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/sidecar.enabled") "false" }}
grpc_port: {{ env "NOMAD_PORT_grpcS" }}
state_file: "cache.json"
operator_config: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/operator.config") "\"\"" }}
network: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/eth.network") "\"testnet\"" }}
eth_oracle:
  rpc:
    local: "http://127.0.0.1:8545"
    {{- with secret "static_secrets/zenrock" }}
    testnet: "{{ .Data.data.holesky_endpoint }}"
    {{- end -}}{{ with secret "static_secrets/alchemy" }}
    mainnet: "{{ .Data.data.eth_endpoint }}"
    {{- end }}
  contract_addrs:
    service_manager: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/config.service_manager") "\"\"" }}
    price_feeds:
      btc: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/config.price_feed_btc") "\"\"" }}
      eth: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/config.price_feed_eth") "\"\"" }}
    zenbtc:
      controller:
        testnet: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/config.zenbtc_controller_testnet") "\"\"" }}
      token:
        ethereum:
          testnet: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/config.zenbtc_token_ethereum_testnet") "\"\"" }}
    network_name:
      mainnet: "Ethereum Mainnet"
      testnet: "Holešky Ethereum Testnet"
solana_rpc:
  testnet: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/solana_rpc.testnet") "\"\"" }}
  mainnet: ""
proxy_rpc:
  url: ""
  user: ""
  password: ""
neutrino:
  path: "/home/zenrock/.zrchain/neutrino"
