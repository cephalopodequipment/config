# -- op-node configuration

# [required] replace with your preferred L1 (Ethereum, not Unichain) node RPC URL:
OP_NODE_L1_ETH_RPC=http://10.20.30.107:63001

# [required] replace with your preferred L1 CL beacon endpoint:
OP_NODE_L1_BEACON=http://10.20.30.107:55008

OP_NODE_NETWORK=unichain-sepolia
OP_NODE_L2_ENGINE_AUTH=/shared/jwt.hex
OP_NODE_L2_ENGINE_RPC=ws://10.20.30.105:8551
OP_NODE_LOG_LEVEL=info
OP_NODE_LOG_FORMAT=logfmt
OP_NODE_METRICS_ADDR=0.0.0.0
OP_NODE_METRICS_ENABLED=true
OP_NODE_METRICS_PORT=7300
OP_NODE_P2P_BOOTNODES=enr:-J24QIHsjbBldFkaVUTEkEdwYa51AeCOAWd8bJbUOqGqsWDhScaPGnPERVfRgcCJbK2X8vI-9eB-VTDDNRl7S4e1zPyGAZKhaRjagmlkgnY0gmlwhAOSdXaHb3BzdGFja4OVCgCJc2VjcDI1NmsxoQI0_WNHeARGz-kjyK_s7MjZkTf5xYSHrm7nL4C5LwbyJ4N0Y3CCJAaDdWRwgiQG,enr:-J24QH_0BbED1p4R8lZe0Wk6V9pFonqXMw48X_IVKQhbNsekdWlDkKUUaDWV4FHqWVQpfGPI5IjeqKOaIrTBnup8Ro2GAZKhZyO6gmlkgnY0gmlwhDQPNgiHb3BzdGFja4OVCgCJc2VjcDI1NmsxoQOKqwdtPsP4czpXIFwx56PmThevWwxQJ78gY0QaQxNdU4N0Y3CCJAaDdWRwgiQG,enr:-J24QKCDaIQdjhYZAvhLp__sApHypx1zgiKaFAiSP55klZCpVpiFLvaR8LKSICO0sc_xE3SL-rW2JBbQrtXg9yGcFQuGAZKhaBnzgmlkgnY0gmlwhAOS1UGHb3BzdGFja4OVCgCJc2VjcDI1NmsxoQL0xHUDIhXHIn_8yAKupnuK3c2TbqDdhRIn-IiYV2Wxe4N0Y3CCJAaDdWRwgiQG
OP_NODE_P2P_LISTEN_IP=0.0.0.0
OP_NODE_P2P_LISTEN_TCP_PORT=9222
OP_NODE_P2P_LISTEN_UDP_PORT=9222
OP_NODE_RPC_ADDR=0.0.0.0
OP_NODE_RPC_PORT=9545
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
