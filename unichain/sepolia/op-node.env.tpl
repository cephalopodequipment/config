# -- op-node configuration
# [required] replace with your preferred L1 (Ethereum, not Unichain) node RPC URL:
OP_NODE_L1_ETH_RPC=http://{{ range service "sepolia.eth-execution-rpc" }}{{ .Address }}:{{ .Port }}{{ end }}

# [required] replace with your preferred L1 CL beacon endpoint:
OP_NODE_L1_BEACON=http://{{ range service "sepolia.eth-consensus-grpc" }}{{ .Address }}:{{ .Port }}{{ end }}

OP_NODE_NETWORK={{ env "CHAIN_ID" }}
OP_NODE_L2_ENGINE_AUTH=/shared/jwt.hex
OP_NODE_L2_ENGINE_RPC=ws://{{ env "OP_NODE_EX_IP" }}:{{ env NOMAD_PORT_ex_authrpc }}
OP_NODE_LOG_LEVEL=info
OP_NODE_LOG_FORMAT=logfmt
OP_NODE_METRICS_ADDR=0.0.0.0
OP_NODE_METRICS_ENABLED=true
OP_NODE_METRICS_PORT=7300
OP_NODE_P2P_BOOTNODES={{ key (print (env "CONSUL_PATH") "/p2p.bootnodes") }}
OP_NODE_P2P_LISTEN_IP=0.0.0.0
OP_NODE_P2P_LISTEN_TCP_PORT={{ env NOMAD_PORT_op_p2p }}
OP_NODE_P2P_LISTEN_UDP_PORT={{ env NOMAD_PORT_op_p2p }}
OP_NODE_RPC_ADDR=0.0.0.0
OP_NODE_RPC_PORT={{ env NOMAD_PORT_op_rpc }}
OP_NODE_VERIFIER_L1_CONFS=4
OP_NODE_P2P_NAT=true
OP_NODE_P2P_DISCOVERY_PATH=/data/opnode_discovery_db
OP_NODE_P2P_PEERSTORE_PATH=/data/opnode_peerstore_db
OP_NODE_P2P_PRIV_PATH=/data/opnode_p2p_priv.txt

# Execution Layer Sync
# op-node can drive the Execution Client to sync from the EL layer. This enables Snap Sync in op-geth or staged sync in op-reth.
# This requires the EL Client to be peered.
# By default, OP geth uses snap sync, but can use full sync (executes every block) while OP_NODE_SYNCMODE=execution-layer as well.
OP_NODE_SYNCMODE=execution-layer
