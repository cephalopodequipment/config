address: false
broadcast-timeout: 5m
chain-id: {{env "CHAIN_ID"}}
executor: "rest:{{- with secret (env "EXECUTOR") -}}{{ .Data.data.executor }}{{-end-}}?timeout=10s"
gas-prices: "{{env "GAS_PRICES"}}"
log-level: {{env "LOG_LEVEL"}}
max-report: "10"
max-try: "5"
node: {{env "VALOPER"}}
rpc-poll-interval: 1s
validator: "{{env "VALOPER"}}"
