# This is a TOML config file.
# For more information, see https://github.com/toml-lang/toml

###############################################################################
###                           RPC Configuration                             ###
###############################################################################

# Specify the celestia app rest rpc address.
core-rpc = {{ key  (print (env "CONSUL_PATH") "/celestia.rpc") }}

# Specify the celestia app grpc address.
core-grpc = {{ key  (print (env "CONSUL_PATH") "/celestia.grpc") }}

# allow gRPC over insecure channels, if not TLS the server must use TLS.
grpc-insecure = true

###############################################################################
###                         P2P Configuration                               ###
###############################################################################

# Comma-separated multiaddresses of p2p peers to connect to.
# Example: "/ip4/127.0.0.1/tcp/30001/p2p/12D3K...,/ip4/127.0.0.1/tcp/30000/p2p/12D3K..."
bootstrappers = {{ keyOrDefault  (print (env "CONSUL_PATH") "/p2p.bootstrappers") "\"\"" }}

# MultiAddr for the p2p peer to listen on.
listen-addr = "/ip4/0.0.0.0/tcp/{{ env "NOMAD_PORT_p2p" }}"