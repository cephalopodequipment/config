# Tendermint KMS configuration file v0.14.0

[[providers.softsign]]
chain_ids = ["{{ env "CHAIN_ID" }}"]
key_type = "consensus"
path = "/home/tmkms/secrets/consensus.key"

[[chain]]
id = "{{ env "CHAIN_ID" }}"
key_format = { type = "bech32", account_key_prefix = "{{ env "ACCT_KEY_PREFIX" }}", consensus_key_prefix = "{{ env "CONSENSUS_KEY_PREFIX" }}" }
state_file = "/home/tmkms/state/state.json"
sign_extensions = {{ env "SIGN_EXTENSIONS" "false" }}

[[validator]]
chain_id = "{{ env "CHAIN_ID" }}"
{{- range service ( printf "%s.cometbft-tmkms" ( env "CHAIN_ID" )) }}
addr = "{{ .Address }}:{{ .Port }}"
{{ end -}}
secret_key = "/home/tmkms/secrets/kms-identity.key"
protocol_version = "v0.34"
reconnect = true