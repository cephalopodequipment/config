[Node]
  StartupTimeout = "2m0s"
  ShutdownTimeout = "2m0s"

[Core]
  IP = "127.0.0.1"
  Port = "9090"
  TLSEnabled = false
  XTokenPath = ""
  AdditionalCoreEndpoints = []

[State]
  DefaultKeyName = "my_celes_key"
  DefaultBackendName = "test"
  EstimatorAddress = ""
  EnableEstimatorTLS = false

[P2P]
  ListenAddresses = {{ key (print (env "CONSUL_PATH") "/p2p.info") }}
  AnnounceAddresses = []
  NoAnnounceAddresses = ["/ip4/127.0.0.1/udp/2121/quic-v1/webtransport", "/ip4/0.0.0.0/udp/2121/quic-v1/webtransport", "/ip6/::/udp/2121/quic-v1/webtransport", "/ip4/0.0.0.0/udp/2121/quic-v1", "/ip4/127.0.0.1/udp/2121/quic-v1", "/ip6/::/udp/2121/quic-v1", "/ip4/0.0.0.0/udp/2121/webrtc-direct", "/ip4/127.0.0.1/udp/2121/webrtc-direct", "/ip6/::/udp/2121/webrtc-direct", "/ip4/0.0.0.0/tcp/2121", "/ip4/127.0.0.1/tcp/2121", "/ip6/::/tcp/2121"]
  MutualPeers = []
  PeerExchange = true
  [P2P.ConnManager]
    Low = 800
    High = 1000
    GracePeriod = "1m0s"

[RPC]
  Address = "0.0.0.0"
  Port = "{{ env "NOMAD_PORT_rpc" }}"
  SkipAuth = false
  [RPC.CORS]
    Enabled = false
    AllowedOrigins = []
    AllowedHeaders = []
    AllowedMethods = []

[Share]
  BlockStoreCacheSize = 128
  UseShareExchange = true
  UseBitswap = true
  [Share.EDSStoreParams]
    RecentBlocksCacheSize = 10
  [Share.ShrexClient]
    ReadTimeout = "2m0s"
    WriteTimeout = "5s"
  [Share.ShrexServer]
    ReadTimeout = "5s"
    WriteTimeout = "1m0s"
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
  TrustedPeers = []
  [Header.Store]
    StoreCacheSize = 2048
    IndexCacheSize = 4096
    WriteBatchSize = 64
  [Header.Syncer]
    PruningWindow = "0s"
    SyncFromHash = ""
    SyncFromHeight = 0
  [Header.Server]
    WriteDeadline = "8s"
    ReadDeadline = "1m0s"
    RequestTimeout = "10s"
  [Header.Client]
    MaxHeadersPerRangeRequest = 64
    RequestTimeout = "8s"
