# op-node configuration
{{ with secret "static_secrets/ankr" }}
# [required] replace with your preferred L1 (Ethereum, not Unichain) node RPC URL:
OP_NODE_L1_ETH_RPC={{ .Data.data.eth_sepolia_rpc }}

# [required] replace with your preferred L1 CL beacon endpoint:
OP_NODE_L1_BEACON={{ .Data.data.eth_sepolia_beacon }}
{{ end }}

OP_NODE_NETWORK=unichain-sepolia
OP_NODE_L2_ENGINE_AUTH=/shared/jwt.hex
OP_NODE_L2_ENGINE_RPC={{ env "NOMAD_HOST_IP_ex_rpc" }}:{{ env "NOMAD_PORT_ex_rpc" }}
OP_NODE_LOG_LEVEL=info
OP_NODE_LOG_FORMAT=logfmt
OP_NODE_METRICS_ADDR=0.0.0.0
OP_NODE_METRICS_ENABLED=true
OP_NODE_METRICS_PORT={{ env "NOMAD_PORT_op_prom" }}
OP_NODE_P2P_LISTEN_IP=0.0.0.0
OP_NODE_P2P_LISTEN_TCP_PORT={{ env "NOMAD_PORT_op_p2p" }}
OP_NODE_P2P_LISTEN_UDP_PORT={{ env "NOMAD_PORT_op_p2p" }}
OP_NODE_RPC_ADDR=0.0.0.0
OP_NODE_RPC_PORT={{ env "NOMAD_PORT_op_rpc" }}
OP_NODE_VERIFIER_L1_CONFS=4
OP_NODE_P2P_NAT=true
OP_NODE_P2P_DISCOVERY_PATH=/data/opnode_discovery_db
OP_NODE_P2P_PEERSTORE_PATH=/data/opnode_peerstore_db
OP_NODE_P2P_PRIV_PATH=/data/opnode_p2p_priv.txt

OP_NODE_P2P_BOOTNODES={{ key (print (env "CONSUL_PATH") "/p2p.bootnodes") }}

# Execution Layer Sync
# op-node can drive the Execution Client to sync from the EL layer. This enables Snap Sync in op-geth or staged sync in op-reth.
# This requires the EL Client to be peered.
# By default, OP geth uses snap sync, but can use full sync (executes every block) while OP_NODE_SYNCMODE=execution-layer as well.
OP_NODE_SYNCMODE=execution-layer

# op-geth configuration

GETH_OP_NETWORK=unichain-sepolia
GETH_ROLLUP_SEQUENCERHTTP=https://sepolia-sequencer.unichain.org
GETH_LOG_FORMAT=logfmt
GETH_VERBOSITY=3
GETH_DATADIR=/data
GETH_HTTP=true
GETH_HTTP_ADDR=0.0.0.0
GETH_HTTP_PORT={{ env "NOMAD_HOST_PORT_rpc" }}
GETH_HTTP_API=web3,debug,eth,txpool,net,admin,rpc
GETH_WS=true
GETH_WS_ADDR=0.0.0.0
GETH_WS_PORT={{ env "NOMAD_HOST_PORT_ws" }}
GETH_WS_API=web3,debug,eth,txpool,net,admin,rpc
GETH_AUTHRPC_JWTSECRET=/shared/jwt.hex
GETH_AUTHRPC_PORT={{ env "NOMAD_HOST_PORT_ex_authrpc" }}
GETH_AUTHRPC_ADDR=0.0.0.0
GETH_METRICS=true
GETH_METRICS_ADDR=0.0.0.0
GETH_METRICS_PORT={{ env "NOMAD_PORT_prom" }}
GETH_ROLLUP_DISABLETXPOOLGOSSIP=true
GETH_TXPOOL_NOLOCALS=true

GETH_BOOTNODES={{ key (print (env "GETH_CONSUL_PATH") "/geth.bootnodes") }}