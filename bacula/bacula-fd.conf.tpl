Director {
  Name = "bacula-dir"
  Password = "{{with secret "bacula/bacula-dir"}}{{.Data.data.password}}{{end}}"
  Address = "{{ range service "bacula-dir"}}{{.Address}}{{end}}"
}

FileDaemon {                          # this is me
  Name = "{{ env "NOMAD_JOB_NAME"}}"
  FDport = 9102                  # where we listen for the director
  WorkingDirectory = /usr/share/bacula
  Pid Directory = /home/bacula
  Maximum Concurrent Jobs = 5
  Plugin Directory = /opt/bacula/plugins
}

Messages {
  Name = Daemon
  director = home-dir = all
}
