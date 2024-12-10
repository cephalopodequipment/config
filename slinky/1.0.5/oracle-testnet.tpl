{
  "providers": {
    "dydx_migration_api": {
      "api": {
        "endpoints": [
          {
            "url":  {{ range service "dydx-testnet-validator.cosmos-sdk-rest" }}"http://{{ .Address }}:{{ .Port }}"{{ end }}
          },
          {
            "url":  {{ range service "dydx-testnet-validator.cosmos-sdk-grpc" }}"{{ .Address }}:{{ .Port }}"{{ end }}
          }
        ]
      }
    },
    "raydium_api": {
      "api": {
        "endpoints": [
          {{- $configs := (key "networks/dydx-testnet/slinky/raydium_api_config" | parseJSON) -}}
          {{- range $i, $api_config := $configs -}}
          {{- with secret (printf "static_secrets/dydx-testnet/slinky-api/%s" $api_config.provider) }}
          {
            "url": "{{ $api_config.url }}",
            "authentication": {
              "apiKey": "{{ .Data.data.api_key }}",
              "apiKeyHeader": "x-api-key"
            }
          }{{ if ne (add $i 1) (len $configs) }},{{ end -}}{{ end -}}{{- end }}          
        ]
      }
    },
    "uniswapv3_api-ethereum": {
      "api": {
        "endpoints": [
          {{- $configs := (key "networks/dydx-testnet/slinky/uniswapv3_api-ethereum_config" | parseJSON) -}}
          {{- range $i, $api_config := $configs -}}
          {{- with secret (printf "static_secrets/dydx-testnet/slinky-api/%s" $api_config.provider) }}
          {
            "url": "{{ $api_config.url }}",
            "authentication": {
              "apiKey": "{{ .Data.data.api_key }}",
              "apiKeyHeader": "x-api-key"
            }
          }{{ if ne (add $i 1) (len $configs) }},{{ end -}}{{ end -}}{{- end }}          
        ]
      }
    },
    "uniswapv3_api-base": {
      "api": {
        "endpoints": [
          {{- $configs := (key "networks/dydx-testnet/slinky/uniswapv3_api-base_config" | parseJSON) -}}
          {{- range $i, $api_config := $configs -}}
          {{- with secret (printf "static_secrets/dydx-testnet/slinky-api/%s" $api_config.provider) }}
          {
            "url": "{{ $api_config.url }}",
            "authentication": {
              "apiKey": "{{ .Data.data.api_key }}",
              "apiKeyHeader": "x-api-key"
            }
          }{{ if ne (add $i 1) (len $configs) }},{{ end -}}{{ end -}}{{- end }}          
        ]
        
      }
    }
  }
}

