{
    "providers": {
        "raydium_api": {
            "api": {
                "endpoints": [
                    {{ with secret "static_secrets/dydx/solana-api-keys" -}}
                    {
                        "url": "https://solana.polkachu.com",
                        "authentication": {
                            "apiKey": "{{ .Data.data.polkachu }}",
                            "apiKeyHeader": "X-Api-Key"
                        }
                    },
#                    {
#                        "url": "https://slinky-solana.kingnodes.com",
#                        "authentication": {
#                            "apiKey": "{{ .Data.data.kingnodes }}",
#                            "apiKeyHeader": "X-Api-Key"
#                        }
#                    },
                    {
                        "url": "https://solana-rpc.rhino-apis.com",
                        "authentication": {
                            "apiKey": "{{ .Data.data.rhino }}",
                            "apiKeyHeader": "X-Api-Key"
                        }
                    },
                    {
                        "url": "https://dydx.helius-rpc.com",
                        "authentication": {
                            "apiKey": "{{ .Data.data.helius }}",
                            "apiKeyHeader": "X-Api-Key"
                        }
                    }
                    {{ end }}
                ]
            }
        }
    },
    "metrics": {
        "prometheusServerAddress": "0.0.0.0:{{ envOrDefault "PROMETHEUS_PORT" "8002" }}",
        "enabled": true
    },
    "host": "0.0.0.0",
    "port": "{{ envOrDefault "API_PORT" "8080" }}"
}
