
# Provisioner Configuration Example

# Server settings
port = "8080"
external_binaries_path = "/usr/bin"

# Vault settings
vault_addr = "{{ env "VAULT_ADDRESS" }}"

{{- with secret "static_secrets/eth2-provisioner" }}
vault_role_id = "{{ .Data.data.role_id}}"
vault_secret_id = "{{ .Data.data.secret_id}}"
{{- end }}

# Validator settings
max_validators_per_job = 200
validator_job_names = [
{{- $names := (env "VALIDATOR_JOB_NAMES") | split "," -}}
{{- range $index, $element := $names -}}
{{- if $index }}, {{ end }}"{{ $element }}"
{{- end -}}
]

# Consul settings
consul_addr = "{{ env "CONSUL_ADDRESS" }}"
consul_token = ""  # Leave empty if using environment variables or command-line flags

# Environment settings
log_level = "debug"
dev_mode = false
wallet_endpoint = true # provides a create wallet endpoint for testing turn off in prod
eth_network = "{{ env "ETH_NETWORK" }}"  # Options: mainnet, holesky
key_manager_port = 7500

# Transaction Verification
tx_verification_on = {{ envOrDefault "TX_VERIFICATION_ON" "true" }} # turn off for development staging no broadcast txs
execution_node_rpc = "{{ env "EXECUTION_NODE_RPC" }}"
eth_tx_verification_timeout = "{{ envOrDefault "ETH_TX_VERIFICATION_TIMEOUT" "45s" }}"  # time to keep checking whether transaction executed

# Eth2 beaconchain parameters
deposit_cli_version = "2.7.0" # the deposit cli version used for creating keystores and deposit files

[rate_limiter]
requests_per_minute = {{ envOrDefault "RATE_LIMITER_REQUESTS_PER_MINUTE" "30.0" }}
burst = 3
