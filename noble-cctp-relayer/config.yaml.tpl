networks:
  source:
    ethereum:
      enabled: true
      domain-id: {{ key (print (env "CONSUL_PATH") "/evm_domain-id") }}
      rpc: "{{ with secret (print (env "VAULT_PATH")) }}{{ .Data.data.evm_rpc_endpoint }}{{ end }}"
      message-transmitter: "{{ key (print (env "CONSUL_PATH") "/message-transmitter") }}"
      request-queue-size: 1000
      start-block: {{ keyOrDefault (print (env "CONSUL_PATH") "/start-block") 0 }}
      lookback-period: {{ keyOrDefault (print (env "CONSUL_PATH") "/lookback-period") 0 }}
  destination:
    noble:
      domain-id: 4
      api: "{{ range service "network-node" }}{{ if .Tags | contains "noble-1" }}{{ if .Tags | contains "sentry0" }}http://{{ .Address }}:{{ index .ServiceMeta "PortRest" }}{{ end }}{{ end }}{{ end }}"
      rpc: "{{ range service "network-node" }}{{ if .Tags | contains "noble-1" }}{{ if .Tags | contains "sentry0" }}http://{{ .Address }}:{{ index .ServiceMeta "PortRpc" }}{{ end }}{{ end }}{{ end }}"
      chain-id: "noble-1"
      gas-limit: 200000
      broadcast-retries: 5
      broadcast-retry-interval: 5
      filter-forwards-by-ibc-channel: false
      forwarding-channel-whitelist:
  enabled-routes:
    {{ key (print (env "CONSUL_PATH") "/evm_domain-id") }}: 4 
  minters:
    {{ key (print (env "CONSUL_PATH") "/evm_domain-id") }}:
      minter-address: "{{ with secret (print (env "VAULT_PATH")) }}{{ .Data.data.evm_minter_address }}{{ end }}"
      minter-private-key : "{{ with secret (print (env "VAULT_PATH")) }}{{ .Data.data.evm_minter_private_key }}{{ end }}"
    4:
      minter-address: "{{ with secret (print (env "VAULT_PATH")) }}{{ .Data.data.noble_minter_address }}{{ end }}"  # "noble1...."
      minter-private-key: "{{ with secret (print (env "VAULT_PATH")) }}{{ .Data.data.noble_minter_private_key }}{{ end }}"
circle:
  attestation-base-url: "https://iris-api.circle.com/attestations/"
  fetch-retries: 10 
  fetch-retry-interval: 10
processor-worker-count: 16
api:
  trusted-proxies:
    - "{{ keyOrDefault (print (env "CONSUL_PATH") "/trusted-proxies")  "0.0.0.0"}}" # "1.2.3.4" # add trusted proxy IPs here