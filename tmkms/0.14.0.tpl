# Tendermint KMS configuration file

[[providers.softsign]]
chain_ids = ["{{ env "CHAIN_ID" }}"]
key_type = "consensus"
path = "/home/tmkms/secrets/consensus.key"


[[chain]]
id = "{{ env "CHAIN_ID" }}"
key_format = { type = "bech32", account_key_prefix = "{{ env "ACCT_KEY_PREFIX" }}", consensus_key_prefix = "{{ env "CONSENSUS_KEY_PREFIX" }}" }
state_file = "/home/tmkms/state/state.json"
sign_extensions = {{ envOrDefault "SIGN_EXTENSIONS" "false" }}


[[validator]]
chain_id = "{{ env "CHAIN_ID" }}"
addr = "{{ env "NODE_LADDR" }}"
secret_key = "/home/tmkms/secrets/kms-identity.key"
protocol_version = "{{ envOrDefault "PROTOCOL_VERSION" "v0.34" }}"
reconnect = true
