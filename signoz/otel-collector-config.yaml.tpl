receivers:
  tcplog/docker:
    listen_address: "0.0.0.0:2256"
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
        from: body.labels
        to: attributes.container_labels
      - type: json_parser
        id: raw_log_parser
        parse_from: body.raw_log
        if: 'body.raw_log matches "^{.*}$"'
      - type: move
        from: body.raw_log
        to: attributes.raw_log
      - type: copy
        from: attributes.raw_log
        to: body
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
  {{ range service "server1.clickhouse-client" }}
clickhouselogsexporter:
  dsn: tcp://{{ .Address }}:{{ .Port }}/signoz_logs
  docker_multi_node_cluster: ${DOCKER_MULTI_NODE_CLUSTER}
  timeout: 10s
# logging: {}
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