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
  <exclude>
    key log

    # bugsnag - for events emitted by the injective nodes
    # Dragonberry - lots of these useless things
    #
    pattern /^Dragonberry|bugsnag/
  </exclude>
</filter>

<filter node.sdk.**> # "node.sdk" tag is set by the logging driver config in the nomad job
  @type parser
  key_name log
  <parse>
    @type json
    time_type string
    time_format %Y-%m-%dT%H:%M:%S%z
  </parse>
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
   impl ${record["impl"].to_s}
   sequence ${record["sequence"].to_s}
 </record>
</filter>

<match node.sdk.**>
  @type elasticsearch

  # Elasticsearch connection settings
  host {{ key "log/elastic/elastic.ip" }}
  port {{ key "log/elastic/elastic.port" }}
  user {{ key "log/elastic/elastic.user" }}
  password {{ key "log/elastic/bootstrap.password" }}

  log_es_400_reason true # leaving this on so we can understand why some records are rejected

  logstash_format true
  logstash_prefix {{ env "node.unique.name" }}
  logstash_dateformat %Y%m

  include_tag_key true # This will add the Fluentd tag in the JSON record
</match>