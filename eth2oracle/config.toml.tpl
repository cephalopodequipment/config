# Oracle Mode Configuration
# if verify_only_mode is true only the merkel root is verified and oracle doesnt act as operator
verify_only_mode = {{ keyOrDefault (print (env "CONSUL_PATH") "/verify_only_mode") "true" }}
storage_path = "/home/eth2oracle/.eth2oracle/data"

# Network Configuration
{{- with secret "static_secrets/ankr" }}
# Ethereum beacon chain node endpoint
consensus_rpc =  "{{ .Data.data.eth_holesky_beacon_rpc }}"
# Ethereum execution node endpoint
execution_rpc = "{{ .Data.data.eth_holesky_rpc }}"   
{{ end -}}

# Address of the deployed smoothing pool contract
pool_contract_address = "{{ key (print (env "CONSUL_PATH" ) "/pool_contract_address")}}"
# number of retries for failed requests
num_retries = 3                                          
# Service Configuration

# levels are info warning debug etc
log_level = "{{ key (print (env "CONSUL_PATH" ) "/log_level")}}"
# port to access oracleapi
api_port = "{{ env "NOMAD_PORT_api" }}"
# port for Prometheus metrics  
prom_port = "{{ env "NOMAD_PORT_prom" }}"              

# Oracle Key Configuration (not required for verify-only mode only when verify only mode is false)
# Password protected key file containing the oracle operator keystore
oracle_key_file = "/keys/keystore.json"
# location of password to decrypt the keystore      
oracle_key_password =  "/keys/password.txt"

# Validator Check Frequency how often to check for new validators if running in operator mode and not in verify-only mode
validator_check_frequency =  "{{ key (print (env "CONSUL_PATH" ) "/validator_check_frequency")}}"

# Reward Distribution Frequency how often to distribute rewards if running in operator mode and not in verify-only mode
reward_distribution_frequency = "{{ key (print (env "CONSUL_PATH" ) "/reward_distribution_frequency")}}"

# Operator Balance Threshold if running in operator mode and not in verify-only mode
# default to .01 Eth if not set
operator_balance_threshold = "{{ key (print (env "CONSUL_PATH" ) "/operator_balance_threshold") }}"  # minimum operator wallet threshold for gas fees

# Validator client message url for messaging a service which validators have been subscribed
validator_client_message_url = ""

# Validator Client Configuration (required when verify_only_mode = false) - add for each validator client
[[validator_clients]]
{{- range service "prov-validator0" }}
url = "http://{{ .Address }}:{{ .ServiceMeta.PortHttp }}"    # URL for the first provisioner validator client
{{- end }}

{{- with secret (print "eth2_provisioner/validators/prov-validator0") }}
jwt_token = "{{ .Data.data.jwt_token }}"
{{- end }}                                  # JWT token for authentication

[[validator_clients]]
{{- range service "prov-validator1" }}
url = "http://{{ .Address }}:{{ .ServiceMeta.PortHttp }}"    # URL for the 2nd provisioner validator client
{{- end }}

{{- with secret (print "eth2_provisioner/validators/prov-validator1") }}
jwt_token = "{{ .Data.data.jwt_token }}"                                  # JWT token for authentication
{{- end }}
