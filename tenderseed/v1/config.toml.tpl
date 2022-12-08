# path to address book (relative to tendermint-seed home directory or an absolute path)
addr_book_file = "data/addrbook.json"

# Set true for strict routability rules
# Set false for private or local networks
addr_book_strict = {{ keyOrDefault (print (env "CONSUL_PATH") "/p2p.addr_book_strict") "true" }}

# network identifier (todo move to cli flag argument? keeps the config network agnostic)
chain_id = "{{ env "NODE_CHAIN_ID" }}"

# Address to listen for incoming connections
laddr = "tcp://0.0.0.0:{{ env "NOMAD_PORT_p2p" }}"

# maximum number of inbound connections
max_num_inbound_peers = {{ keyOrDefault (print (env "CONSUL_PATH") "/p2p.max_num_inbound_peers") "100" }}

# maximum number of outbound connections
max_num_outbound_peers = {{ keyOrDefault (print (env "CONSUL_PATH") "/p2p.max_num_outbound_peers") "25" }}

# maximum size of a message packet payload, in bytes
max_packet_msg_payload_size = {{ keyOrDefault (print "networks/" (index (env "CONSUL_PATH" | split "/") 1) "/p2p.max_packet_msg_payload_size") "1024" }}

# path to node_key (relative to tendermint-seed home directory or an absolute path)
node_key_file = "config/node_key.json"

# seed nodes we can use to discover peers
seeds = {{ keyOrDefault (print "networks/" (index (env "CONSUL_PATH" | split "/") 1) "/p2p.seeds") "\"\"" }}
