log-level = "info"
log-style = "pretty"
testnet = {{ keyOrDefault (print (env "JESTER_CONSUL_PATH") "/jester.testnet") "false" }}
server-address = "localhost:{{ env "NOMAD_PORT_gRPCJ" }}"

[ethereum]
  websocket-url = {{ keyOrDefault (print (env "JESTER_CONSUL_PATH") "/jester.websocket-url") "\"\"" }}
  rpc-url = {{ keyOrDefault (print (env "JESTER_CONSUL_PATH") "/jester.rpc-url") "\"\"" }}

[metrics]
  enabled = true
  address = 0.0.0.0:{{ env "NOMAD_PORT_promJ" }}"
