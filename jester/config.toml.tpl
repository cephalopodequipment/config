log-level = "{{ keyOrDefault (print (env "JESTER_CONSUL_PATH") "/jester.log_level") "info" }}"
log-style = "pretty"
testnet = {{ keyOrDefault (print (env "JESTER_CONSUL_PATH") "/jester.testnet") "false" }}
server-address = "0.0.0.0:{{ env "NOMAD_PORT_gRPCJ" }}"

[ethereum]
{{- with secret "static_secrets/ankr" }}
websocket-url = "{{ .Data.data.eth_mainnet_ws }}"
rpc-url = "{{ .Data.data.rpc_endpoint }}"
{{- end }}

[metrics]
enabled = true
address = "0.0.0.0:{{ env "NOMAD_PORT_promJ" }}"
