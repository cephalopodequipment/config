networks:
  source:
    ethereum:
      enabled: true
      domain-id: {{ key (print (env "CONSUL_PATH") "/evm_domain-id") }}
      rpc: "{{ with secret (print (env "VAULT_PATH") }}{{ .Data.data.evm-rpc-endpoint }}{{ end }}"
      message-transmitter: "{{ key (print (env "CONSUL_PATH") "/message-transmitter") }}"  # "0x26413e8157CD32011E726065a5462e97dD4d03D9"
      request-queue-size: 1000
      start-block: {{ keyOrDefault (print (env "CONSUL_PATH") "/start-block") 0 }} # set to 0 to default to latest block
      lookback-period: {{ keyOrDefault (print (env "CONSUL_PATH") "/lookback-period") 0 }} # historical blocks to look back on launch
  destination:
    noble:
      domain-id: 4
      api: "{{ range service "network-node" }}{{ if .Tags | contains "noble-1" }}{{ if .Tags | contains "sentry0" }}http://{{ .Address }}:{{ index .ServiceMeta "PortRest" }}{{ end }}{{ end }}{{ end }}"
      rpc: "{{ range service "network-node" }}{{ if .Tags | contains "noble-1" }}{{ if .Tags | contains "sentry0" }}http://{{ .Address }}:{{ index .ServiceMeta "PortRpc" }}{{ end }}{{ end }}{{ end }}"
      chain-id: "noble-1"
      gas-limit: 200000
      broadcast-retries: 5 # number of times to attempt the broadcast
      broadcast-retry-interval: 5 # time between retries in seconds
      filter-forwards-by-ibc-channel: false
      forwarding-channel-whitelist:
  # source domain id -> destination domain id
  enabled-routes:
    {{ key (print (env "CONSUL_PATH") "/evm_domain-id") }}: 4 # ethereum to noble
  # destination domain -> minter metadata
  minters:
    {{ key (print (env "CONSUL_PATH") "/evm_domain-id") }}:
      minter-address: "{{ with secret (print (env "VAULT_PATH") }}{{ .Data.data.evm-minter-address }}{{ end }}"  # "noble1...."
      minter-private-key : "{{ with secret (print (env "VAULT_PATH") }}{{ .Data.data.evm-minter-private-key }}{{ end }}" # hex encoded, no prepended 0x
    4:
      minter-address: "{{ with secret (print (env "VAULT_PATH") }}{{ .Data.data.noble-minter-address }}{{ end }}"  # "noble1...."
      minter-private-key: "{{ with secret (print (env "VAULT_PATH") }}{{ .Data.data.noble-minter-private-key }}{{ end }}" # hex encoded, no prepended 0x
circle:
  attestation-base-url: "https://iris-api.circle.com/attestations/"
  fetch-retries: 10 # additional times to fetch an attestation
  fetch-retry-interval: 10 # time between retries in seconds
processor-worker-count: 16
api:
  trusted-proxies:
    - "{{ keyOrDefault (print (env "CONSUL_PATH") "/trusted-proxies")  "0.0.0.0"}}" # "1.2.3.4" # add trusted proxy IPs here