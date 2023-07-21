[chains]
endpoints = [
  { name = "{{ env "CHAIN" }}", comet_version = "{{ env "COMET_VERSION" }}", url = "{{ env "WEBSOCKET" }}" },
]

[database]
path = "{{ env "DB_PATH" }}"

[metrics]
enabled = true
port    = {{ env "PORT" }}
