log-level = "{{ keyOrDefault (print (env "JESTER_CONSUL_PATH") "/jester.log_level") "info" }}"
log-style = "pretty"
testnet = {{ keyOrDefault (print (env "JESTER_CONSUL_PATH") "/jester.testnet") "false" }}
server-address = "0.0.0.0:{{ env "NOMAD_PORT_gRPCJ" }}"

[ethereum]
websocket-url = "ws://10.10.11.110:54004"
rpc-url = "http://10.10.11.110:53001"

[metrics]
enabled = true
address = "0.0.0.0:{{ env "NOMAD_PORT_promJ" }}"
