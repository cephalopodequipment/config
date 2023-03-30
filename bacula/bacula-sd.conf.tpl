Storage {                             # definition of myself
  Name = "bacula-sd"
  SDPort = 9103                  # Director's port
  WorkingDirectory = "/usr/share/bacula"
  Pid Directory = "/home/bacula"
  Plugin Directory = "/etc/bacula/plugins"
  Maximum Concurrent Jobs = 20
}

Director {
  Name = "bacula-dir"
  Password = "{{with secret "bacula/bacula-dir"}}{{.Data.data.password}}{{end}}"
  Address = "{{ range service "bacula-dir"}}{{.Address}}{{end}}"
}

Director {
  Name = "bacula-mon"
  Password = "{{with secret "bacula/bacula-dir"}}{{.Data.data.password}}{{end}}"
  Monitor = yes
  Address = "{{ range service "bacula-dir"}}{{.Address}}{{end}}"
}


Device {
  Name = FileChgr1-Dev1
  Media Type = File1
  Archive Device = "/usr/share/bacula/backups"
  LabelMedia = yes;                   # lets Bacula label unlabeled media
  Random Access = Yes;
  AutomaticMount = yes;               # when device opened, read it
  RemovableMedia = no;
  AlwaysOpen = no;
  Maximum Concurrent Jobs = 5
}


Messages {
  Name = Standard
  director = bacula-dir = all
}
