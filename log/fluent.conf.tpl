<system>
  <log>
    format json
    time_format %Y-%m-%dT%H:%M:%S%z
  </log>
</system>

# Source for logs emitted by the docker plugin for fluentd
<source>
  @type forward
  port 5140
  bind 0.0.0.0
</source>

####
##  Handling of fluentd logs
####

<label @FLUENT_LOG> # Defining this label instructs fluentd to send its own logs to this label
  <match fluent.**>
    @type elasticsearch

    # Elasticsearch connection settings
    host {{ key "log/elastic/elastic.ip" }}
    port {{ key "log/elastic/elastic.port" }}
    user {{ key "log/elastic/elastic.user" }}
    password {{ key "log/elastic/bootstrap.password" }}

    logstash_format true
    logstash_prefix fluentd-{{ env "node.unique.name" }}
    logstash_dateformat %Y%m

    # This will add the Fluentd tag in the JSON record
    include_tag_key true
  </match>
</label>

####
##  SDK node logs
####

<filter node.sdk.**>
  @type grep

  ### Excluding these entries for now as they break json parsing
  <exclude>
    key log

    # bugsnag - for events emitted by the injective nodes
    # Dragonberry - lots of these useless things
    # block-manager - agoric nodes logging block begin and commit, kinda useless
    # OnAcknowledgementPacket - stride nodes emit this log line for an IBC ACK
    # validator_set_updater - tgrade x/poe module output. Seems kinda useless
    #
    pattern /^Dragonberry|bugsnag|block-manager|^OnAcknowledgementPacket|validator_set_updater/
  </exclude>
</filter>

<filter node.**> # "node.sdk" tag is set by the logging driver config in the nomad job
  @type parser
  key_name log
  <parse>
    @type json
    time_type string
    time_format %Y-%m-%dT%H:%M:%S%z
  </parse>
</filter>

<filter node.sdk.injective.**>
  @type rename_key
  enable_ruby true
  rename_rule1 msg message
</filter>

# These records can all be handled better however the way they are logged in JSON format is... problematic
<filter node.sdk.**>
 @type record_transformer
 enable_ruby true
 <record>
   #Setting these fields to string for various reasons
   #TODO: open some issues / PR to tendermint / SDK to fix these logs
   height ${record["height"].to_s} # `x/ibc/client` module outputs height as `1-xxxx`
   hash ${record["hash"].to_s} # `consensus` module outputs hash as `{}` when logging "finalizing commit of block"
   peer ${record["peer"].to_s}
   addr ${record["addr"].to_s}
   address ${record["addr"].to_s}
   impl ${record["impl"].to_s}
   type ${record["type"].to_s}
   remote ${record["remote"].to_s}
   sequence ${record["sequence"].to_s}
 </record>
</filter>

<match node.**>
  @type elasticsearch_data_stream
  data_stream_ilm_name sdk-node-logs-policy
  data_stream_name ${tag}

  # Elasticsearch connection settings
  host {{ key "log/elastic/elastic.ip" }}
  port {{ key "log/elastic/elastic.port" }}
  user {{ key "log/elastic/elastic.user" }}
  password {{ key "log/elastic/bootstrap.password" }}

  log_es_400_reason true # leaving this on so we can understand why some records are rejected

  logstash_format true
  logstash_prefix ${tag}
  logstash_dateformat %Y%m

  include_tag_key true # This will add the Fluentd tag in the JSON record

  # buffer configuration so fluentd doesn't use as much RAM
   <buffer>
     @type file
     flush_mode interval
     flush_thread_count 16
     path /tmp/nomad.buffer
     chunk_limit_size 48MB
     queue_limit_length 512
     flush_interval 5s
     overflow_action drop_oldest_chunk
     retry_max_interval 30s
     retry_forever false
     retry_type exponential_backoff
     retry_timeout 1h
     retry_wait 20s
     retry_max_times 30
   </buffer>
</match>

<match tmkms.**>
  @type elasticsearch_data_stream
  data_stream_ilm_name sdk-node-logs-policy
  data_stream_name ${tag}

  # Elasticsearch connection settings
  host {{ key "log/elastic/elastic.ip" }}
  port {{ key "log/elastic/elastic.port" }}
  user {{ key "log/elastic/elastic.user" }}
  password {{ key "log/elastic/bootstrap.password" }}

  log_es_400_reason true # leaving this on so we can understand why some records are rejected

  logstash_format true
  logstash_prefix ${tag}
  logstash_dateformat %Y%m

  include_tag_key true # This will add the Fluentd tag in the JSON record

  # buffer configuration so fluentd doesn't use as much RAM
   <buffer>
     @type file
     flush_mode interval
     flush_thread_count 16
     path /tmp/tmkms.buffer
     chunk_limit_size 48MB
     queue_limit_length 512
     flush_interval 5s
     overflow_action drop_oldest_chunk
     retry_max_interval 30s
     retry_forever false
     retry_type exponential_backoff
     retry_timeout 1h
     retry_wait 20s
     retry_max_times 30
   </buffer>
</match>

<match ibc.metrics.**>
  @type elasticsearch_data_stream
  data_stream_ilm_name sdk-node-logs-policy
  data_stream_name ${tag}

  # Elasticsearch connection settings
  host {{ key "log/elastic/elastic.ip" }}
  port {{ key "log/elastic/elastic.port" }}
  user {{ key "log/elastic/elastic.user" }}
  password {{ key "log/elastic/bootstrap.password" }}

  log_es_400_reason true # leaving this on so we can understand why some records are rejected

  logstash_format true
  logstash_prefix ${tag}
  logstash_dateformat %Y%m

  include_tag_key true # This will add the Fluentd tag in the JSON record

  # buffer configuration so fluentd doesn't use as much RAM
   <buffer>
     @type file
     flush_mode interval
     flush_thread_count 16
     path /tmp/ibc.metrics.buffer
     chunk_limit_size 48MB
     queue_limit_length 512
     flush_interval 5s
     overflow_action drop_oldest_chunk
     retry_max_interval 30s
     retry_forever false
     retry_type exponential_backoff
     retry_timeout 1h
     retry_wait 20s
     retry_max_times 30
   </buffer>
</match>

####
## Hermes logs
####

# Filter for parsing JSON logs
<filter hermes-*>
  @type parser
  key_name log
  format json
  reserve_data true
</filter>

# Match for sending logs to Elasticsearch
<match hermes-*>
  @type elasticsearch_data_stream
  data_stream_ilm_name sdk-node-logs-policy
  data_stream_name ${tag}

  # Elasticsearch connection settings
  host {{ key "log/elastic/elastic.ip" }}
  port {{ key "log/elastic/elastic.port" }}
  user {{ key "log/elastic/elastic.user" }}
  password {{ key "log/elastic/bootstrap.password" }}

  log_es_400_reason true # leaving this on so we can understand why some records are rejected

  logstash_format true
  logstash_prefix ${tag}
  logstash_dateformat %Y%m

  include_tag_key true # This will add the Fluentd tag in the JSON record

  # buffer configuration so fluentd doesn't use as much RAM
  <buffer>
    @type file
    flush_mode interval
    flush_thread_count 16
    path /tmp/hermes.buffer
    chunk_limit_size 48MB
    queue_limit_length 512
    flush_interval 5s
    overflow_action drop_oldest_chunk
    retry_max_interval 30s
    retry_forever false
    retry_type exponential_backoff
    retry_timeout 1h
    retry_wait 20s
    retry_max_times 30
  </buffer>
</match>
