log-level = "{{ keyOrDefault (print (env "JESTER_CONSUL_PATH") "/jester.log_level") "info" }}"
log-style = "pretty"
testnet = {{ keyOrDefault (print (env "JESTER_CONSUL_PATH") "/jester.testnet") "false" }}
server-address = "0.0.0.0:{{ env "NOMAD_PORT_gRPCJ" }}"

[ethereum]
websocket-url = "{{ range service "eth-full-node3.geth-ws" }}ws://{{ .Address }}:{{ .Port }}{{ end }}"
rpc-url = "{{ range service "eth-full-node3.geth-rpc" }}http://{{ .Address }}:{{ .Port }}{{ end }}"

[metrics]
enabled = true
address = "0.0.0.0:{{ env "NOMAD_PORT_promJ" }}"
