global:
  scrape_interval: {{ keyOrDefault (print (env "CONSUL_PATH") "/prom-server/scrape-interval") "6s" }}

scrape_configs:
  - job_name: '{{ env "NOMAD_JOB_NAME" }}'
    static_configs:
      - targets: ['{{ env "NOMAD_IP_prom" }}:{{ env "NOMAD_HOST_PORT_prom" }}']