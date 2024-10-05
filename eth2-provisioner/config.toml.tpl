
# Provisioner Configuration Example

# Server settings
port = "8080"
external_binaries_path = "/usr/bin"

# Vault settings
vault_addr = "http://10.20.30.101:8200"

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
consul_addr = "http://10.20.30.101:8500"
consul_token = ""  # Leave empty if using environment variables or command-line flags

# Environment settings
log_level = "debug"
dev_mode = false
environment = "staging"
eth_network = "{{ env "ETH_NETWORK" }}"  # Options: mainnet, holesky
key_manager_port = 7500

# Transaction Verification
tx_verification_on = false # turn off for development staging no broadcast txs
execution_node_rpc = "http://10.20.30.105:53001"
eth_tx_verification_timeout = "45s"  # time to keep checking whether transaction executed

# Eth2 beaconchain parameters
deposit_cli_version = "2.7.0" # the deposit cli version used for creating keystores and deposit files
