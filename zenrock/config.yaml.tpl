enabled: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/sidecar.enabled") "true" }}
grpc_port: {{ env "NOMAD_PORT_grpcS" }}
zrchain_rpc: "localhost:{{ env "NOMAD_PORT_zrpc" }}"
state_file: "cache.json"
operator_config: "{{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/operator.config") "" }}"
network: "{{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/eth.network") "mainnet" }}"
eth_oracle:
  rpc:
    local: "http://127.0.0.1:8545"
    {{- with secret "static_secrets/ethereum/alchemy" }}
    testnet: "{{ .Data.data.eth_holesky }}"
    mainnet: "{{ .Data.data.eth_mainnet }}"
    {{- end -}}
  contract_addrs:
    service_manager: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/config.service_manager") "\"\"" }}
    price_feeds:
      btc: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/config.price_feed_btc") "\"\"" }}
      eth: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/config.price_feed_eth") "\"\"" }}
    zenbtc:
      controller:
        mainnet: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/config.zenbtc_controller") "\"\"" }}
      token:
        ethereum:
          mainnet: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/config.zenbtc_token_ethereum") "\"\"" }}
    network_name:
      mainnet: "Ethereum Mainnet"
      testnet: "Holešky Ethereum Testnet"
solana_rpc:
  testnet: {{ keyOrDefault (print (env "ZENROCK_SIDECAR_CONSUL_PATH") "/solana_rpc.testnet") "\"\"" }}
  mainnet: "https://api.mainnet-beta.solana.com/"
proxy_rpc:
  url: ""
  user: ""
  password: ""
neutrino:
  path: "/home/zenrock/.zrchain/neutrino"
