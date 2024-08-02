{
  "providers": {
    "dydx_migration_api": {
      "api": {
        "endpoints": [
          {
            "url":  {{ range service "dydx-validator.cosmos-sdk-rest" }}"http://{{ .Address }}:{{ .Port }}"{{ end }}
          },
          {
            "url":  {{ range service "dydx-validator.cosmos-sdk-grpc" }}"{{ .Address }}:{{ .Port }}"{{ end }}
          }
        ]
      }
    },
    "raydium_api": {
      "api": {
        "endpoints": [
          {{ with secret "static_secrets/dydx/solana-api-keys" -}}
          {
            "url": "https://solana.polkachu.com",
            "authentication": {
              "apiKey": "{{ .Data.data.polkachu }}",
              "apiKeyHeader": "x-api-key"
            }
          },
          {
            "url": "https://slinky-solana.kingnodes.com",
            "authentication": {
              "apiKey": "{{ .Data.data.kingnodes }}",
              "apiKeyHeader": "X-Api-Key"
            }
          },
          {
            "url": "https://dydx.helius-rpc.com",
            "authentication": {
              "apiKey": "{{ .Data.data.helius }}",
              "apiKeyHeader": "x-api-key"
            }
          }
          {{ end -}}
        ]
      }
    }
  }
}