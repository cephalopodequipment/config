## Generate slinky configuration

Currently, the `slinky` binary config needs to be generated using the 
`slinky-config` application. This needs access to a running node for
the chain slinky is providing oracle services to.

The `raydium` api keys for each provider have to be manually added to
the template because the list can change based on what is provided to
`slinky-config` when it runs.

`slinky-config` command example

```shell
slinky-config --chain dydx --node-http-url "http://localhost:1317" --raydium-enabled --solana-node-endpoint https://solana.polkachu.com,https://slinky-solana.kingnodes.com,https://solana-rpc.rhino-apis.com,https://dydx.helius-rpc.com
```