[Application Options]
; Logging level for all subsystems
LogLevel = {{ keyOrDefault (print (env "CONSUL_PATH") "/base.log_level") "debug" }}

; Type of keyring to use
KeyringBackend = {{ keyOrDefault (print (env "CONSUL_PATH") "/keyring.backend") "test" }}

; the listener for RPC connections, e.g., 127.0.0.1:1234
RPCListener = 0.0.0.0:12582

[metrics]
; IP of the Prometheus server
Host = 0.0.0.0

; Port of the Prometheus server
Port = 2113

; The interval of Prometheus metrics updated
UpdateInterval = 1000ms

[dbconfig]
; The directory path in which the database file should be stored.
DBPath = /home/eotsd/.eotsd/data

; The name of the database file.
DBFileName = eots.db

; Prevents the database from syncing its freelist to disk, resulting in improved performance at the expense of increased startup time.
NoFreelistSync = false

; Specifies if a Bolt based database backend should be automatically compacted on startup (if the minimum age of the database file is reached). This will require additional disk space for the compacted copy of the database but will result in an overall lower database size after the compaction.
AutoCompact = false

; Specifies the minimum time that must have passed since a bolt database file was last compacted for the compaction to be considered again.
AutoCompactMinAge = 168h0m0s

; Specifies the timeout value to use when opening the wallet database.
DBTimeout = 1m0s

