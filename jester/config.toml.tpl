log-level = "info"
log-style = "pretty"
testnet = {{ keyOrDefault (print (env "JESTER_CONSUL_PATH") "/jester.testnet") "false" }}
server-address = "localhost:{{ env "NOMAD_PORT_gRPCJ" }}"

[ethereum]
  {{- with secret "static_secrets/jester" }}
  websocket-url: "{{ .Data.data.ws_endpoint }}"
  rpc-url: "{{ .Data.data.rpc_endpoint }}"
  {{- end }}

[metrics]
  enabled = true
  address = 0.0.0.0:{{ env "NOMAD_PORT_promJ" }}"
