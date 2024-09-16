
# Provisioner Configuration Example

# Server settings
port = "8080"
external_binaries_path = "/usr/bin"

# Vault settings
vault_addr = "http://vault.service.devenv-cec.consul:8200"

{{- with secret "static_secrets/eth2-provisioner" }}
vault_role_id = "{{ .Data.data.role_id}}"
vault_secret_id = "{{ .Data.data.secret_id}}"
{{- end }}

# Validator settings
max_validators_per_job = 200
generate_prysm_keystore = true

validator_job_names = [
{{- $names := (env "VALIDATOR_JOB_NAMES") | split "," -}}
{{- range $index, $element := $names -}}
{{- if $index }}, {{ end }}"{{ $element }}"
{{- end -}}
]

# Consul settings
consul_addr = "http://consul.service.devenv-cec.consul:8500"
consul_token = ""  # Leave empty if using environment variables or command-line flags

# Environment settings
dev_mode = false
environment = "staging"
eth_network = "{{ env "ETH_NETWORK" }}"  # Options: mainnet, holesky
key_manager_port = 7500
