grpc_port: {{ env "NOMAD_PORT_grpcS" }}
state_file: "cache.json"
operator_config: "/home/zenrock/.zrchain/sidecar/eigen_operator_config.yaml"
network: "testnet"
eth_oracle:
  rpc:
    local: "http://127.0.0.1:8545"
    testnet: "https://holesky.infura.io/v3/c21b9a2253ea41abb0c4205e23e92706"
    mainnet: "https://eth-mainnet.g.alchemy.com/v2/b9IwcZs-IpmHL-4vGWcU5KXe35CbJfJe"
  contract_addrs:
    service_manager: "0xa559CDb9e029fc4078170122eBf7A3e622a764E4"
    price_feed: "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419"
    network_name: "Holešky Ethereum Testnet"
solana_rpc:
  testnet: "https://api.testnet.solana.com"
  mainnet: ""
proxy_rpc:
  url: ""
  user: ""
  password: ""
neutrino:
  path: "home/zenrock/.zrchain/neutrino"