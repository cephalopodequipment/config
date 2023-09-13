[chains.{{ env "CHAIN_ID" }}]
url = "{{ env "URL" }}"
comet_version = "{{ envOrDefault "COMET_VERSION" "0.34" }}"

[database]
path = "{{ env "DB_PATH" }}"

[metrics]
enabled = true
port    = {{ env "INTERNAL_METRICS_PORT" }}
