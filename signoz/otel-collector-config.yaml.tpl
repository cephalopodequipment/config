receivers:
  tcplog/docker:
    listen_address: "0.0.0.0:2256"
    max_log_size: 5MiB
    operators:
      - type: json_parser
        id: logspout_parser
        parse_to: body
      - type: filter
        id: signoz_logs_filter
        expr: 'body.container_name matches "^/signoz-(logspout|frontend|alertmanager|query-service|otel-collector|clickhouse|zookeeper)"'
      - type: move
        from: body.container_name
        to: attributes.container_name
      - type: move
        from: body.labels.nomad_job_name
        to: attributes.nomad_job_name
        if: 'body.labels.nomad_job_name != nil'
      - type: move
        from: body.labels.nomad_client_name
        to: attributes.nomad_client_name
        if: 'body.labels.nomad_client_name != nil'
      - type: move
        from: body.labels.nomad_task_name
        to: attributes.nomad_task_name
        if: 'body.labels.nomad_task_name != nil'
      - type: move
        from: body.labels
        to: attributes.container_labels
      
      # Try to parse raw_log as JSON first
      - type: json_parser
        id: raw_log_parser
        parse_from: body.raw_log
        if: 'body.raw_log matches "^\\s*\\{.*\\}\\s*$"'
        on_error: send
      
      # If raw_log is pipe-delimited format, parse it
      - type: regex_parser
        id: pipe_delimited_parser
        regex: '^(?P<local_timestamp>[^\|]+) \| (?P<timestamp>[^\s]+) (?P<severity_text>\w+) (?P<message>.*)$'
        parse_from: body.raw_log
        parse_to: attributes.parsed_log
        if: 'body.raw_log matches "^[0-9]{4}-[0-9]{2}-[0-9]{2}.*\\|"'
        on_error: send
      
      # Extract severity from parsed pipe-delimited logs
      - type: move
        from: attributes.parsed_log.severity_text
        to: attributes.severity_text
        if: 'attributes.parsed_log.severity_text != nil'
      
      # Extract timestamp from parsed pipe-delimited logs
      - type: move
        from: attributes.parsed_log.timestamp
        to: attributes.log_timestamp
        if: 'attributes.parsed_log.timestamp != nil'
      
      # Extract message from parsed pipe-delimited logs
      - type: move
        from: attributes.parsed_log.message
        to: attributes.log_message
        if: 'attributes.parsed_log.message != nil'
      
      # Clean up temporary parsed_log object
      - type: remove
        field: attributes.parsed_log
        if: 'attributes.parsed_log != nil'
      
      # Move raw_log to attributes for reference
      - type: move
        from: body.raw_log
        to: attributes.raw_log
      
      # Set body based on what we have
      - type: copy
        from: attributes.log_message
        to: body
        if: 'attributes.log_message != nil'
      
      # If no log_message (JSON logs), use raw_log as body
      - type: copy
        from: attributes.raw_log
        to: body
        if: 'attributes.log_message == nil'
      
      # Clean up raw_log from attributes after copying to body
      - type: remove
        field: attributes.raw_log

  otlp:
    protocols:
      grpc:
        endpoint: 0.0.0.0:4317
      http:
        endpoint: 0.0.0.0:4318

processors:
  batch:
    send_batch_size: 10000
    send_batch_max_size: 11000
    timeout: 10s

extensions:
  health_check:
    endpoint: 0.0.0.0:13133
  zpages:
    endpoint: 0.0.0.0:55679
  pprof:
    endpoint: 0.0.0.0:1777

exporters:
  {{- range service "server1.clickhouse-client" }}
  clickhouselogsexporter:
    dsn: tcp://signoz@{{ .Address }}:{{ .Port }}/signoz_logs
    timeout: 10s
  # logging: {}
  {{ end }}
  {{- range service "server1.clickhouse-client" }}
  signozclickhousemetrics:
    dsn: tcp://signoz@{{ .Address }}:{{ .Port }}/signoz_metrics
  {{ end }}
  {{- range service "server1.clickhouse-client" }}
  signozclickhousemeter:
    dsn: tcp://signoz@{{ .Address }}:{{ .Port }}/signoz_meter
    timeout: 45s
    sending_queue:
      enabled: false
  {{ end }}

service:
  extensions:
    - health_check
    - zpages
    - pprof
  pipelines:
    logs:
      receivers: [otlp, tcplog/docker]
      processors: [batch]
      exporters: [clickhouselogsexporter]
    metrics:
      receivers: [otlp]
      processors: [batch]
      exporters: [signozclickhousemetrics]
