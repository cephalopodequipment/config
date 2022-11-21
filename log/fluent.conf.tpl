<system>
  log_level debug
</system>

<source>
  @type forward
  @label @{{ env "node.unique.name" }}
  port 1470
  bind 0.0.0.0
</source>

<label @{{ env "node.unique.name" }}>
  <filter *.**>
    @type parser
    key_name log
    <parse>
      @type json
      time_type string
      time_format %Y-%m-%dT%H:%M:%S%z
    </parse>
  </filter>

  # These records can all be handled better however the way they are logged in JSON format is... problematic
  <filter>
    @type record_transformer
    enable_ruby true
    <record>
      height ${record["height"].to_s}
      peer ${record["peer"].to_s}
      addr ${record["addr"].to_s}
      impl ${record["impl"].to_s}
      sequence ${record["sequence"].to_s}
    </record>
  </filter>

  <match *.**>
    @type elasticsearch

    # Elasticsearch connection settings
    host {{ key "log/elastic/elastic.ip" }}
    port {{ key "log/elastic/elastic.port" }}
    user {{ key "log/elastic/elastic.user" }}
    password {{ key "log/elastic/bootstrap.password" }}

    log_es_400_reason true

    logstash_format true
    logstash_prefix fluentd-{{ env "node.unique.name" }}
    logstash_dateformat %Y%m%d

    # This will add the Fluentd tag in the JSON record
    include_tag_key true
  </match>
</label>
