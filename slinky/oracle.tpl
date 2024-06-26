{
  "updateInterval": 250000000,
  "maxPriceAge": 120000000000,
  "providers": [
    {
      "name": "binance_api",
      "api": {
        "enabled": true,
        "timeout": 3000000000,
        "interval": 750000000,
        "reconnectTimeout": 2000000000,
        "maxQueries": 1,
        "atomic": true,
        "url": "https://api.binance.com/api/v3/ticker/price?symbols=%s%s%s",
        "endpoints": null,
        "batchSize": 0,
        "name": "binance_api"
      },
      "webSocket": {
        "enabled": false,
        "maxBufferSize": 0,
        "reconnectionTimeout": 0,
        "wss": "",
        "name": "",
        "readBufferSize": 0,
        "writeBufferSize": 0,
        "handshakeTimeout": 0,
        "enableCompression": false,
        "readTimeout": 0,
        "writeTimeout": 0,
        "pingInterval": 0,
        "maxReadErrorCount": 0,
        "maxSubscriptionsPerConnection": 0
      },
      "type": "price_provider"
    },
    {
      "name": "coinbase_api",
      "api": {
        "enabled": true,
        "timeout": 3000000000,
        "interval": 100000000,
        "reconnectTimeout": 2000000000,
        "maxQueries": 5,
        "atomic": false,
        "url": "https://api.coinbase.com/v2/prices/%s/spot",
        "endpoints": null,
        "batchSize": 0,
        "name": "coinbase_api"
      },
      "webSocket": {
        "enabled": false,
        "maxBufferSize": 0,
        "reconnectionTimeout": 0,
        "wss": "",
        "name": "",
        "readBufferSize": 0,
        "writeBufferSize": 0,
        "handshakeTimeout": 0,
        "enableCompression": false,
        "readTimeout": 0,
        "writeTimeout": 0,
        "pingInterval": 0,
        "maxReadErrorCount": 0,
        "maxSubscriptionsPerConnection": 0
      },
      "type": "price_provider"
    },
    {
      "name": "kraken_api",
      "api": {
        "enabled": true,
        "timeout": 3000000000,
        "interval": 600000000,
        "reconnectTimeout": 2000000000,
        "maxQueries": 1,
        "atomic": true,
        "url": "https://api.kraken.com/0/public/Ticker?pair=%s",
        "endpoints": null,
        "batchSize": 0,
        "name": "kraken_api"
      },
      "webSocket": {
        "enabled": false,
        "maxBufferSize": 0,
        "reconnectionTimeout": 0,
        "wss": "",
        "name": "",
        "readBufferSize": 0,
        "writeBufferSize": 0,
        "handshakeTimeout": 0,
        "enableCompression": false,
        "readTimeout": 0,
        "writeTimeout": 0,
        "pingInterval": 0,
        "maxReadErrorCount": 0,
        "maxSubscriptionsPerConnection": 0
      },
      "type": "price_provider"
    },
    {
      "name": "volatile-exchange-provider",
      "api": {
        "enabled": true,
        "timeout": 500000000,
        "interval": 500000000,
        "reconnectTimeout": 500000000,
        "maxQueries": 1,
        "atomic": false,
        "url": "volatile-exchange-provider",
        "endpoints": null,
        "batchSize": 0,
        "name": "volatile-exchange-provider"
      },
      "webSocket": {
        "enabled": false,
        "maxBufferSize": 0,
        "reconnectionTimeout": 0,
        "wss": "",
        "name": "",
        "readBufferSize": 0,
        "writeBufferSize": 0,
        "handshakeTimeout": 0,
        "enableCompression": false,
        "readTimeout": 0,
        "writeTimeout": 0,
        "pingInterval": 0,
        "maxReadErrorCount": 0,
        "maxSubscriptionsPerConnection": 0
      },
      "type": "price_provider"
    },
    {
      "name": "bitfinex_ws",
      "api": {
        "enabled": false,
        "timeout": 0,
        "interval": 0,
        "reconnectTimeout": 0,
        "maxQueries": 0,
        "atomic": false,
        "url": "",
        "endpoints": null,
        "batchSize": 0,
        "name": ""
      },
      "webSocket": {
        "enabled": true,
        "maxBufferSize": 1000,
        "reconnectionTimeout": 10000000000,
        "wss": "wss://api-pub.bitfinex.com/ws/2",
        "name": "bitfinex_ws",
        "readBufferSize": 0,
        "writeBufferSize": 0,
        "handshakeTimeout": 45000000000,
        "enableCompression": false,
        "readTimeout": 45000000000,
        "writeTimeout": 45000000000,
        "pingInterval": 0,
        "maxReadErrorCount": 100,
        "maxSubscriptionsPerConnection": 0
      },
      "type": "price_provider"
    },
    {
      "name": "bitstamp_ws",
      "api": {
        "enabled": false,
        "timeout": 0,
        "interval": 0,
        "reconnectTimeout": 0,
        "maxQueries": 0,
        "atomic": false,
        "url": "",
        "endpoints": null,
        "batchSize": 0,
        "name": ""
      },
      "webSocket": {
        "enabled": true,
        "maxBufferSize": 1024,
        "reconnectionTimeout": 10000000000,
        "wss": "wss://ws.bitstamp.net",
        "name": "bitstamp_ws",
        "readBufferSize": 0,
        "writeBufferSize": 0,
        "handshakeTimeout": 45000000000,
        "enableCompression": false,
        "readTimeout": 225000000000,
        "writeTimeout": 45000000000,
        "pingInterval": 10000000000,
        "maxReadErrorCount": 100,
        "maxSubscriptionsPerConnection": 0
      },
      "type": "price_provider"
    },
    {
      "name": "bybit_ws",
      "api": {
        "enabled": false,
        "timeout": 0,
        "interval": 0,
        "reconnectTimeout": 0,
        "maxQueries": 0,
        "atomic": false,
        "url": "",
        "endpoints": null,
        "batchSize": 0,
        "name": ""
      },
      "webSocket": {
        "enabled": true,
        "maxBufferSize": 1000,
        "reconnectionTimeout": 10000000000,
        "wss": "wss://stream.bybit.com/v5/public/spot",
        "name": "bybit_ws",
        "readBufferSize": 0,
        "writeBufferSize": 0,
        "handshakeTimeout": 45000000000,
        "enableCompression": false,
        "readTimeout": 45000000000,
        "writeTimeout": 45000000000,
        "pingInterval": 15000000000,
        "maxReadErrorCount": 100,
        "maxSubscriptionsPerConnection": 0
      },
      "type": "price_provider"
    },
    {
      "name": "crypto_dot_com_ws",
      "api": {
        "enabled": false,
        "timeout": 0,
        "interval": 0,
        "reconnectTimeout": 0,
        "maxQueries": 0,
        "atomic": false,
        "url": "",
        "endpoints": null,
        "batchSize": 0,
        "name": ""
      },
      "webSocket": {
        "enabled": true,
        "maxBufferSize": 1024,
        "reconnectionTimeout": 10000000000,
        "wss": "wss://stream.crypto.com/exchange/v1/market",
        "name": "crypto_dot_com_ws",
        "readBufferSize": 0,
        "writeBufferSize": 0,
        "handshakeTimeout": 45000000000,
        "enableCompression": false,
        "readTimeout": 45000000000,
        "writeTimeout": 45000000000,
        "pingInterval": 0,
        "maxReadErrorCount": 100,
        "maxSubscriptionsPerConnection": 0
      },
      "type": "price_provider"
    },
    {
      "name": "gate_ws",
      "api": {
        "enabled": false,
        "timeout": 0,
        "interval": 0,
        "reconnectTimeout": 0,
        "maxQueries": 0,
        "atomic": false,
        "url": "",
        "endpoints": null,
        "batchSize": 0,
        "name": ""
      },
      "webSocket": {
        "enabled": true,
        "maxBufferSize": 1000,
        "reconnectionTimeout": 10000000000,
        "wss": "wss://api.gateio.ws/ws/v4/",
        "name": "gate_ws",
        "readBufferSize": 0,
        "writeBufferSize": 0,
        "handshakeTimeout": 45000000000,
        "enableCompression": false,
        "readTimeout": 45000000000,
        "writeTimeout": 45000000000,
        "pingInterval": 0,
        "maxReadErrorCount": 100,
        "maxSubscriptionsPerConnection": 0
      },
      "type": "price_provider"
    },
    {
      "name": "huobi_ws",
      "api": {
        "enabled": false,
        "timeout": 0,
        "interval": 0,
        "reconnectTimeout": 0,
        "maxQueries": 0,
        "atomic": false,
        "url": "",
        "endpoints": null,
        "batchSize": 0,
        "name": ""
      },
      "webSocket": {
        "enabled": true,
        "maxBufferSize": 1000,
        "reconnectionTimeout": 10000000000,
        "wss": "wss://api.huobi.pro/ws",
        "name": "huobi_ws",
        "readBufferSize": 0,
        "writeBufferSize": 0,
        "handshakeTimeout": 45000000000,
        "enableCompression": false,
        "readTimeout": 45000000000,
        "writeTimeout": 45000000000,
        "pingInterval": 0,
        "maxReadErrorCount": 100,
        "maxSubscriptionsPerConnection": 0
      },
      "type": "price_provider"
    },
    {
      "name": "kucoin_ws",
      "api": {
        "enabled": false,
        "timeout": 5000000000,
        "interval": 60000000000,
        "reconnectTimeout": 0,
        "maxQueries": 1,
        "atomic": false,
        "url": "https://api.kucoin.com",
        "endpoints": null,
        "batchSize": 0,
        "name": "kucoin_ws"
      },
      "webSocket": {
        "enabled": true,
        "maxBufferSize": 1024,
        "reconnectionTimeout": 10000000000,
        "wss": "wss://ws-api-spot.kucoin.com/",
        "name": "kucoin_ws",
        "readBufferSize": 0,
        "writeBufferSize": 0,
        "handshakeTimeout": 45000000000,
        "enableCompression": false,
        "readTimeout": 45000000000,
        "writeTimeout": 45000000000,
        "pingInterval": 10000000000,
        "maxReadErrorCount": 100,
        "maxSubscriptionsPerConnection": 0
      },
      "type": "price_provider"
    },
    {
      "name": "mexc_ws",
      "api": {
        "enabled": false,
        "timeout": 0,
        "interval": 0,
        "reconnectTimeout": 0,
        "maxQueries": 0,
        "atomic": false,
        "url": "",
        "endpoints": null,
        "batchSize": 0,
        "name": ""
      },
      "webSocket": {
        "enabled": true,
        "maxBufferSize": 1000,
        "reconnectionTimeout": 10000000000,
        "wss": "wss://wbs.mexc.com/ws",
        "name": "mexc_ws",
        "readBufferSize": 0,
        "writeBufferSize": 0,
        "handshakeTimeout": 45000000000,
        "enableCompression": false,
        "readTimeout": 45000000000,
        "writeTimeout": 45000000000,
        "pingInterval": 20000000000,
        "maxReadErrorCount": 100,
        "maxSubscriptionsPerConnection": 20
      },
      "type": "price_provider"
    },
    {
      "name": "okx_ws",
      "api": {
        "enabled": false,
        "timeout": 0,
        "interval": 0,
        "reconnectTimeout": 0,
        "maxQueries": 0,
        "atomic": false,
        "url": "",
        "endpoints": null,
        "batchSize": 0,
        "name": ""
      },
      "webSocket": {
        "enabled": true,
        "maxBufferSize": 1000,
        "reconnectionTimeout": 10000000000,
        "wss": "wss://ws.okx.com:8443/ws/v5/public",
        "name": "okx_ws",
        "readBufferSize": 0,
        "writeBufferSize": 0,
        "handshakeTimeout": 45000000000,
        "enableCompression": false,
        "readTimeout": 45000000000,
        "writeTimeout": 45000000000,
        "pingInterval": 0,
        "maxReadErrorCount": 100,
        "maxSubscriptionsPerConnection": 0
      },
      "type": "price_provider"
    },
    {
      "name": "uniswapv3_api-ethereum",
      "api": {
        "enabled": true,
        "timeout": 1000000000,
        "interval": 2000000000,
        "reconnectTimeout": 2000000000,
        "maxQueries": 1,
        "atomic": true,
        "url": "https://eth.public-rpc.com/",
        "endpoints": null,
        "batchSize": 0,
        "name": "uniswapv3_api-ethereum"
      },
      "webSocket": {
        "enabled": false,
        "maxBufferSize": 0,
        "reconnectionTimeout": 0,
        "wss": "",
        "name": "",
        "readBufferSize": 0,
        "writeBufferSize": 0,
        "handshakeTimeout": 0,
        "enableCompression": false,
        "readTimeout": 0,
        "writeTimeout": 0,
        "pingInterval": 0,
        "maxReadErrorCount": 0,
        "maxSubscriptionsPerConnection": 0
      },
      "type": "price_provider"
    },
    {
      "name": "dydx_api",
      "api": {
        "enabled": true,
        "timeout": 20000000000,
        "interval": 10000000000,
        "reconnectTimeout": 2000000000,
        "maxQueries": 1,
        "atomic": true,
        {{ range service "dydx-mainnet-validator.node-sdk-rest" }}
        "url": "http://{{ .Address }}:{{ .Port }}", {{ end }}
        "endpoints": null,
        "batchSize": 0,
        "name": "dydx_api"
      },
      "webSocket": {
        "enabled": false,
        "maxBufferSize": 0,
        "reconnectionTimeout": 0,
        "wss": "",
        "name": "",
        "readBufferSize": 0,
        "writeBufferSize": 0,
        "handshakeTimeout": 0,
        "enableCompression": false,
        "readTimeout": 0,
        "writeTimeout": 0,
        "pingInterval": 0,
        "maxReadErrorCount": 0,
        "maxSubscriptionsPerConnection": 0
      },
      "type": "market_map_provider"
    },
    {
      "name": "raydium_api",
      "api": {
        "enabled": true,
        "timeout": 500000000,
        "interval": 500000000,
        "reconnectTimeout": 2000000000,
        "maxQueries": 10,
        "atomic": false,
        "url": "",
        "endpoints": [
        {{ with secret "static_secrets/dydx/solana-api-keys" -}}
          {
            "url": "https://solana.polkachu.com",
            "authentication": {
              "apiKey": "{{ .Data.data.polkachu }}",
              "apiKeyHeader": "X-Api-Key"
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
        ],
        "batchSize": 50,
        "name": "raydium_api"
      },
      "webSocket": {
        "enabled": false,
        "maxBufferSize": 0,
        "reconnectionTimeout": 0,
        "wss": "",
        "name": "",
        "readBufferSize": 0,
        "writeBufferSize": 0,
        "handshakeTimeout": 0,
        "enableCompression": false,
        "readTimeout": 0,
        "writeTimeout": 0,
        "pingInterval": 0,
        "maxReadErrorCount": 0,
        "maxSubscriptionsPerConnection": 0
      },
      "type": "price_provider"
    }
  ],
  "production": false,
  "metrics": {
    "prometheusServerAddress": "0.0.0.0:{{ envOrDefault "PROMETHEUS_PORT" "8002" }}",
    "enabled": true
  },
  "host": "0.0.0.0",
  "port": "{{ envOrDefault "API_PORT" "8080" }}"
}
