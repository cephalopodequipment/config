log-level = "info"
log-style = "pretty"
testnet = {{ keyOrDefault (print (env "JESTER_CONSUL_PATH") "/jester.testnet") "false" }}
server-address = "localhost:{{ env "NOMAD_PORT_gRPCJ" }}"

[ethereum]
  {{- with secret "static_secrets/jester" }}
  websocket-url: "{{ .Data.data.sepolia_ws_endpoint }}"
  {{- end -}}{{ with secret "static_secrets/jester" }}
  rpc-url: "{{ .Data.data.sepolia_endpoint }}"
  {{- end }}

[metrics]
  enabled = true
  address = 0.0.0.0:{{ env "NOMAD_PORT_promJ" }}"
