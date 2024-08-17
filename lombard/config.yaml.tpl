babylon:
  url: "{{ env "BABYLON_URL" }}"
  timeout: "60s"

bitcoin:
  host: "{{- with secret static_secrets/lombard/btc_fullnode -}}{{- .Data.data.url -}}{{- end -}}"
  user: "{{- with secret static_secrets/lombard/btc_fullnode -}}{{- .Data.data.user -}}{{- end -}}"
  password: "{{- with secret static_secrets/lombard/btc_fullnode -}}{{- .Data.data.password -}}{{- end -}}"
  params: "{{ env "BTC_NETWORK" }}"
  disabletls: "{{ env "BTC_FULLNODE_DISABLE_TLS" }}"
  required-confirmations: 3
  change-address: "{{ env "BTC_CHANGE_ADDRESS" }}"
  max-fee-rate: "{{ env "BTC_MAX_FEE_RATE" }}"

blockchain:
  ethereum:
    enabled: "true"
    confirmation-blocks: "65"
    endpoints: "{{- with secret static_secrets/lombard/eth_fullnode -}}{{- .Data.data.url -}}{{- end -}}"
    blockchain: "EVM"
    chain-id: "{{ env "ETH_CHAIN_ID"}}"
    block-time: "{{ enc "ETH_BLOCK_TIME"}}"
    lbtc-address: "{{ env "ETH_LBTC_ADDRESS" }}"

consensus:
  listen-address: 0.0.0.0:61785
  data-dir: {{ env "HOME_DIR"}}/raftdir
  cluster-id: 0
  certs-dir: "{{ env "HOME_DIR"}}/certs/mainnet/"
  private-key-file: "{{ env "HOME_DIR"}}/certs/mainnet/{{ key (print (env "CONSUL_PATH") "/node_id") }}.key"
  node-id: {{ key (print (env "CONSUL_PATH") "/node_id") }}
  members:
{{ key (print (env "CONSUL_PATH") "/members") }}

crypto:
  enabled-curves: "ECDSA_SECP256K1,ECDSA_SECP256R1,EDDSA_ED25519"

cubist:
  session: "{{- with secret static_secrets/lombard/cubist -}}{{- .Data.data.session_token -}}{{- end -}}"
  preapproved-session: "{{- with secret static_secrets/lombard/cubist -}}{{- .Data.data.preapproved_session_token -}}{{- end -}}"
  timeout: "60s"
  key-type: "SecpBtcTest"
  deposit-role-id: "{{- with secret static_secrets/lombard/cubist -}}{{- .Data.data.deposit_role_id -}}{{- end -}}"
  staking-role-id: "{{- with secret static_secrets/lombard/cubist -}}{{- .Data.data.staking_role_id -}}{{- end -}}"
  deposit-key: "{{- with secret static_secrets/lombard/cubist -}}{{- .Data.data.deposit_key -}}{{- end -}}"

database:
  pebble-data-dir: {{ env "HOME_DIR"}}/pebbble/datadir
  pebble-encryption-key: "{{- with secret static_secrets/lombard/db -}}{{- .Data.data.pebble_encryption_key -}}{{- end -}}"

gateway:
  grpc-address: :6565
  http-address: :8000

sanction:
  url: "{{ env "LOMBARD_SANCTION_URL" }}"
  timeout: "60s"

