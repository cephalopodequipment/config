AVAILABILITY_GW_ENDPOINT:
  {{ key (print (env "CONSUL_PATH") "/AVAILABILITY_GW_ENDPOINT")  }}
VAULTS_MERKLE_HEIGHT:
  31
ORDERS_MERKLE_HEIGHT:
  63
POLLING_INTERVAL:
  1
VALIDATE_ORDERS:
  {{ key (print (env "CONSUL_PATH") "/VALIDATE_ORDERS")  }}
PRIVATE_KEY_PATH:
  {{ key (print (env "CONSUL_PATH") "/PRIVATE_KEY_PATH")  }}
CERTIFICATES_PATH:
  {{ key (print (env "CONSUL_PATH") "/CERTIFICATES_PATH")  }}

LOGGING:
  version: 1
  disable_existing_loggers: False
  formatters:
    plaintext:
      format: "[%(asctime)s] %(process)d %(levelname)s %(name)s:%(funcName)s:%(lineno)s - %(message)s"
  handlers:
    console:
      class: logging.StreamHandler
      level: DEBUG
      formatter: plaintext
      stream: ext://sys.stdout
  loggers:
    root:
      level: INFO
      handlers: [console]
    committee:
      level: DEBUG
      handlers: [console]

STORAGE:
  class: starkware.storage.aerospike_storage_threadpool.AerospikeLayeredStorage
  config:
    hosts:
      - {{ key (print (env "CONSUL_PATH") "/aerospike.host")  }}
    namespace: {{ key (print (env "CONSUL_PATH") "/aerospike.namespace") | replace "\"" }}
    aero_set: starkware
    index_bits: 28
