moniker = "{{ envOrDefault "NODE_MONIKER" "my-node" }}"

[logging]
log_level = "{{ envOrDefault "LOG_LEVEL" "info" }}"
log_format = "{{ envOrDefault "LOG_FORMAT" "plaintext" }}"

[consensus]
timeout_propose = "{{ envOrDefault "TIMEOUT_PROPOSE" "3s" }}"
timeout_propose_delta = "envOrDefault "TIMEOUT_PROPOSE_DELTA" "500ms" }}"
timeout_prevote = "{{ envOrDefault "TIMEOUT_PREVOTE" "1s" }}"
timeout_prevote_delta = "{{ envOrDefault "TIMEOUT_PREVOTE_DELTA" "500ms" }}"
timeout_precommit = "{{ envOrDefault "TIMEOUT_PRECOMMIT" "1s" }}"
timeout_precommit_delta = "{{ envOrDefault "TIMEOUT_PRECOMMIT_DELTA" "500ms" }}"
timeout_commit = "{{ envOrDefault "TIMEOUT_COMMIT" "1s" }}"
timeout_step = "{{ envOrDefault "TIMEOUT_STEP" "30s" }}"

[consensus.p2p]
listen_addr = "{{ envOrDefault "P2P_LADDR" "/ip4/127.0.0.1/tcp/27000" }}"
persistent_peers = {{ envOrDefault "CONSENSUS_PERSISTENT_PEERS" "[]" }}
transport = "tcp"
pubsub_max_size = "4.2 MB"
rpc_max_size = "10.5 MB"

[consensus.p2p.discovery]
enabled = true
bootstrap_protocol = "full"
selector = "random"
num_outbound_peers = {{ envOrDefault "NUM_OUTBOUND_PEERS" "20" }}
num_inbound_peers = {{ envOrDefault "NUM_INBOUND_PEERS" "20" }}
ephemeral_connection_timeout = "5s"

[consensus.p2p.protocol]
type = "gossipsub"
mesh_n = 6
mesh_n_high = 12
mesh_n_low = 4
mesh_outbound_min = 2

[mempool]
max_tx_count = {{ envOrDefault "MAX_TX_COUNT" "10000" }}
gossip_batch_size = 0

[mempool.p2p]
listen_addr = {{ envOrDefault "MEMPOOL_LADDR" "/ip4/127.0.0.1/tcp/28000" }}
persistent_peers = {{ envOrDefault "MEMPOOL_PERSISTENT_PEERS" "[]" }}
transport = "tcp"
pubsub_max_size = "4.2 MB"
rpc_max_size = "10.5 MB"

[mempool.p2p.discovery]
enabled = false
bootstrap_protocol = "full"
selector = "random"
num_outbound_peers = 20
num_inbound_peers = 20
ephemeral_connection_timeout = "5s"

[mempool.p2p.protocol]
type = "gossipsub"
mesh_n = 6
mesh_n_high = 12
mesh_n_low = 4
mesh_outbound_min = 2

[sync]
enabled = true
status_update_interval = "10s"
request_timeout = "10s"

[metrics]
enabled = true
listen_addr = "{{ envOrDefault "METRICS_LADDR" "0.0.0.0:9090" }}"

[runtime]
flavor = "{{ envOrDefault "RUNTIME_FLAVOR" "single_threaded" }}"

[test]
max_block_size = "1048.6 KB"
value_payload = "parts-only"
tx_size = "1.0 KB"
txs_per_part = 256
time_allowance_factor = 0.5
exec_time_per_tx = "1ms"
max_retain_blocks = 1000

[test.vote_extensions]
enabled = false
size = "0 B"

