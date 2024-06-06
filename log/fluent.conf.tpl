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
    {{- range service "elasticsearch" }}
      host {{ .Address }}
      port {{ index .ServiceMeta "PortHTTP" }}
    {{- end }}
    {{- with secret "static_secrets/fluentd" }}
      user {{ .Data.data.username }}
      password {{ .Data.data.password }}
    {{- end }}

    logstash_format true
    logstash_prefix fluentd-{{ env "node.unique.name" }}

    log_es_400_reason true

    # This will add the Fluentd tag in the JSON record
    include_tag_key true

    # buffer configuration so fluentd doesn't use as much RAM
    <buffer>
      @type file
      flush_mode interval
      flush_thread_count 16
      path /tmp/fluentd.buffer
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
    pattern /^Dragonberry|bugsnag|block-manager|^OnAcknowledgementPacket|validator_set_updater|voteSignBytes|store_client_state/
  </exclude>
</filter>

# of course we're going to add a random fucking ! in front of all our JSON logs...
<filter node.sdk.**>
  @type record_modifier
  <replace>
    key log
    expression /^!\s(?<log>.+)$/
    replace \k<log>
  </replace>
  <replace>
    key log
    expression /(?<hash>"hash"):{}/
    replace \k<hash>:""
  </replace>
  <replace>
    key log
    expression /(?<p>"proposal":)nil/
    replace \k<p>{}
  </replace>
  <replace>
    key log
    expression /(?<p>"proposal"):"Proposal{(?<h>\d+)\/(?<rd>\d)\s\((?<bh>.+):(?<pt>\d):(?<ph>.+),\s(?<pol>.+)\).+@(?<time>.+)}"/
    replace \k<p>:{"Type":32,"height":\k<h>,"round":\k<rd>,"pol_round":\k<pol>,"block_id":{"hash":"\k<bh>","parts":{"total":\k<pt>,"hash":"\k<ph>"}}}
  </replace>
</filter>

<filter node.sdk.**> # "node.sdk" tag is set by the logging driver config in the nomad job
  @type parser
  key_name log
  reserve_time true
  reserve_data true
  <parse>
    @type multi_format
    <pattern>
      format json
      time_type string
      time_format %Y-%m-%dT%H:%M:%S%z
    </pattern>
    <pattern>
      format json
      time_type string
      time_format %Y-%m-%dT%H:%M:%S.%N%z
    </pattern>
  </parse>
</filter>

<filter node.eth.**> # tag is set by the logging driver config in the nomad job
  @type parser
  key_name log
  reserve_time true
  reserve_data true
  <parse>
    @type json
    time_type string
    time_format %Y-%m-%dT%H:%M:%S
  </parse>
</filter>

<filter ibc.metrics.**> # "node.sdk" tag is set by the logging driver config in the nomad job
  @type parser
  key_name log
  reserve_time true
  reserve_data true
  <parse>
    @type multi_format
    <pattern>
      format json
      time_type string
      time_format %Y-%m-%dT%H:%M:%S%z
    </pattern>
    <pattern>
      format json
      time_type string
      time_format %Y-%m-%dT%H:%M:%S.%N%z
    </pattern>
  </parse>
</filter>

# just lol...
<filter node.sdk.nomic.**>
  @type rename_key
  rename_rule1 _msg message
</filter>

# everyone else has time...
<filter node.sdk.nomic.**>
  @type record_modifier
  remove_keys ts
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
   peer ${record["peer"].to_s}
   addr ${record["addr"].to_s}
   address ${record["addr"].to_s}
   impl ${record["impl"].to_s}
   type ${record["type"].to_s}
   remote ${record["remote"].to_s}
   sequence ${record["sequence"].to_s}
 </record>
</filter>

<match **>
  @type elasticsearch_data_stream
  data_stream_name "logs"

  # Elasticsearch connection settings
  {{- range service "elasticsearch" }}
    host {{ .Address }}
    port {{ index .ServiceMeta "PortHTTP" }}
  {{- end }}
  {{- with secret "static_secrets/fluentd" }}
    user {{ .Data.data.username }}
    password {{ .Data.data.password }}
  {{- end }}
  logstash_format false

  log_es_400_reason true
  # This will add the Fluentd tag in the JSON record
  include_tag_key true

  # buffer configuration so fluentd doesn't use as much RAM
  <buffer>
    @type file
    flush_mode interval
    flush_thread_count 16
    path /tmp/logs.buffer
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
