[Node]
  StartupTimeout = "2m0s"
  ShutdownTimeout = "2m0s"

[Core]
  IP = "127.0.0.1"
  RPCPort = "26657"
  GRPCPort = "9090"

[State]
  DefaultKeyName = "my_celes_key"
  DefaultBackendName = "test"

[P2P]
  ListenAddresses = {{ key (print (env "CONSUL_PATH") "/p2p.info") }}
  
  AnnounceAddresses = []

  NoAnnounceAddresses = ["/ip4/127.0.0.1/udp/2121/quic-v1/webtransport", "/ip4/0.0.0.0/udp/2121/quic-v1/webtransport", "/ip6/::/udp/2121/quic-v1/webtransport", "/ip4/0.0.0.0/udp/2121/quic-v1", "/ip4/127.0.0.1/udp/2121/quic-v1", "/ip6/::/udp/2121/quic-v1", "/ip4/0.0.0.0/tcp/2121", "/ip4/127.0.0.1/tcp/2121", "/ip6/::/tcp/2121"]
  MutualPeers = []
  PeerExchange = true
  [P2P.ConnManager]
    Low = 800
    High = 1000
    GracePeriod = "1m0s"

[RPC]
  Address = "0.0.0.0"
  Port = "{{ env "NOMAD_PORT_rpc" }}"
  SkipAuth = true

[Gateway]
  Address = "0.0.0.0"
  Port = "26659"
  Enabled = false

[Share]
  BlockstoreCacheSize = 128
  UseShareExchange = true
  [Share.EDSStoreParams]
    RecentBlocksCacheSize = 10
  [Share.ShrExEDSParams]
    ServerReadTimeout = "5s"
    ServerWriteTimeout = "1m0s"
    HandleRequestTimeout = "1m0s"
    ConcurrencyLimit = 10
    BufferSize = 32768
  [Share.ShrExNDParams]
    ServerReadTimeout = "5s"
    ServerWriteTimeout = "1m0s"
    HandleRequestTimeout = "1m0s"
    ConcurrencyLimit = 10
  [Share.PeerManagerParams]
    PoolValidationTimeout = "2m0s"
    PeerCooldown = "3s"
    GcInterval = "30s"
    EnableBlackListing = false
  [Share.Discovery]
    PeersLimit = 5
    AdvertiseInterval = "1h0m0s"

[Header]
  TrustedHash = ""
  TrustedPeers = []
  [Header.Store]
    StoreCacheSize = 4096
    IndexCacheSize = 16384
    WriteBatchSize = 2048
  [Header.Syncer]
    TrustingPeriod = "336h0m0s"
  [Header.Server]
    WriteDeadline = "8s"
    ReadDeadline = "1m0s"
    RangeRequestTimeout = "10s"
  [Header.Client]
    MaxHeadersPerRangeRequest = 64
    RangeRequestTimeout = "8s"

[Pruner]
  EnableService = false
