wasm_dir = "wasm"

[ledger]
genesis_time = "2023-06-20T17:00:00+00:00"
chain_id = "public-testnet-9.0.5aa315d1a22"

[ledger.shell]
base_dir = "/home/namada/.local/share/namada"
storage_read_past_height_limit = 3600
db_dir = "db"
cometbft_dir = "cometbft"
tendermint_mode = "Validator"

[ledger.cometbft]
proxy_app = "tcp://127.0.0.1:26658"
moniker = "{{ keyOrDefault (print (env "CONSUL_PATH") "/base.moniker") "\"20k leagues under the sea\"" }}"
db_backend = "goleveldb"
db_dir = "data"
log_level = "info"
log_format = "{{ keyOrDefault  (print (env "CONSUL_PATH") "/base.log_format") "\"json\"" }}"
genesis_file = "config/genesis.json"
node_key_file = "config/node_key.json"
abci = "socket"
filter_peers = false
priv_validator_key_file = "config/priv_validator_key.json"
priv_validator_state_file = "data/priv_validator_state.json"
priv_validator_laddr = "{{ if (env "VALIDATOR") | parseBool }} "tcp://0.0.0.0:{{ env "NOMAD_PORT_tmkms" }}" {{ else }} "" {{ end }}"

[ledger.cometbft.rpc]
laddr = "tcp://0.0.0.0:{{ env "NOMAD_PORT_rpc" }}"
cors_allowed_origins = []
cors_allowed_methods = ["HEAD", "GET", "POST"]
cors_allowed_headers = ["Origin", "Accept", "Content-Type", "X-Requested-With", "X-Server-Time"]
unsafe = false
max_open_connections = 900
max_subscription_clients = 100
max_subscriptions_per_client = 5
timeout_broadcast_tx_commit = "10000ms"
max_body_bytes = 1000000
max_header_bytes = 1048576
tls_cert_file = ""
tls_key_file = ""
pprof_laddr = ""

[ledger.cometbft.p2p]
laddr = "tcp://0.0.0.0:{{ env "NOMAD_PORT_p2p" }}"
external_address = "{{ key (print (env "CONSUL_PATH") "/p2p.external_address") }}:{{ env "NOMAD_PORT_p2p" }}"
seeds = ""
persistent_peers = {{ keyOrDefault  (print (env "CONSUL_PATH") "/p2p.persistent_peers") "\"\"" }}
upnp = false
addr_book_file = "config/addrbook.json"
addr_book_strict = true
max_num_inbound_peers = {{ keyOrDefault (print (env "CONSUL_PATH") "/p2p.max_num_inbound_peers") "10" }}
max_num_outbound_peers = {{ keyOrDefault (print (env "CONSUL_PATH") "/p2p.max_num_outbound_peers") "25" }}
unconditional_peer_ids = ""
persistent_peers_max_dial_period = "0ms"
flush_throttle_timeout = "100ms"
max_packet_msg_payload_size = 1024
send_rate = 5120000
recv_rate = 5120000
pex = {{ keyOrDefault (print (env "CONSUL_PATH") "/p2p.pex") "true" }}
seed_mode = false
private_peer_ids = ""
allow_duplicate_ip = false
handshake_timeout = "20000ms"
dial_timeout = "3000ms"

[ledger.cometbft.mempool]
recheck = true
broadcast = true
wal_dir = ""
size = 5000
max_txs_bytes = 1073741824
cache_size = 10000
keep-invalid-txs-in-cache = false
max_tx_bytes = 1048576
max_batch_bytes = 0

[ledger.cometbft.consensus]
wal_file = "data/cs.wal/wal"
double_sign_check_height = 0
create_empty_blocks = true
create_empty_blocks_interval = "0ms"
peer_gossip_sleep_duration = "100ms"
peer_query_maj23_sleep_duration = "2000ms"
timeout_propose = "3000ms"
timeout_propose_delta = "500ms"
timeout_prevote = "1000ms"
timeout_prevote_delta = "500ms"
timeout_precommit = "1000ms"
timeout_precommit_delta = "500ms"
timeout_commit = "10000ms"

[ledger.cometbft.tx_index]
indexer = "null"

[ledger.cometbft.instrumentation]
prometheus = true
prometheus_listen_addr = ":{{ env "NOMAD_PORT_prom" }}"
max_open_connections = 3
namespace = "namada_tm"

[ledger.cometbft.statesync]
enable = {{ keyOrDefault (print (env "CONSUL_PATH") "/statesync.enable") "false" }}
rpc_servers = {{ keyOrDefault (print (env "CONSUL_PATH") "/statesync.rpc_servers") "\"\"" }}
trust_height = {{ keyOrDefault (print (env "CONSUL_PATH") "/statesync.trust_height") "0" }}
trust_hash = {{ keyOrDefault (print (env "CONSUL_PATH") "/statesync.trust_hash") "\"\"" }}
trust_period = {{ keyOrDefault (print "networks/" (index (env "CONSUL_PATH" | split "/") 1) "/statesync.trust_period") "\"168h0m0s\"" }}
discovery_time = "15000ms"
temp_dir = ""
