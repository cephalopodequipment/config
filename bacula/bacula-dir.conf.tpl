 Director {
  Name = "bacula-dir"
  Messages = "Daemon"
  QueryFile = "/etc/bacula/scripts/query.sql"
  WorkingDirectory = "/usr/share/bacula"
  PidDirectory = "/home/bacula"
  MaximumConcurrentJobs = 20
  Password = "{{with secret "bacula/bacula-dir"}}{{.Data.data.password}}{{end}}"
}

### CATALOG COMPONENTS ###
Job {
  Name = "BackupCatalog"
  Level = "Full"
  Fileset = "Catalog"
  Schedule = "WeeklyCycleAfterBackup"
  JobDefs = "DefaultJob"
  WriteBootstrap = "/usr/share/bacula/%n.bsr"
  Runscript {
    RunsWhen = "Before"
    RunsOnClient = no
    Command = "/etc/bacula/scripts/make_catalog_backup.pl MyCatalog"
  }
  Runscript {
    RunsWhen = "After"
    RunsOnClient = no
    Command = "/etc/bacula/scripts/delete_catalog_backup"
  }
  Priority = 11
}

Catalog {
  Name = "MyCatalog"
  Address = "{{with secret "bacula/bacula-dir"}}{{.Data.data.db_host}}{{end}}"
  Password = "{{with secret "bacula/bacula-dir"}}{{.Data.data.db_password}}{{end}}"
  User = "bacula"
  DbName = "bacula"
}

Fileset {
  Name = "Catalog"
  Include {
    File = "/usr/share/bacula/bacula.sql"
    Options {
      Signature = "Md5"
    }
  }
}




### SCHEDULES ###
Schedule {
  Name = "WeeklyCycle"
  Run = Level="Full" 1st sun at 23:05
  Run = Level="Differential" 2nd,3rd,4th,5th sun at 23:05
  Run = Level="Incremental" mon,tue,wed,thu,fri,sat at 23:05
}
Schedule {
  Name = "WeeklyCycleFull"
  Run = Level="Full" at 23:10
}

### FILESETS ###

@|"sh -c 'for f in /etc/bacula/filesets/*.conf ; do echo @${f} ; done'"


### POOLS ###
Pool {
  Name = "FilePool-Small"
  PoolType = "Backup"
  LabelFormat = "FilePool-Small-Vol-"
  MaximumVolumes = 10
  MaximumVolumeBytes = 1G
  VolumeRetention = 30 days
  AutoPrune = yes
  Recycle = yes
}


### LOGGING ###
Messages {
  Name = "Daemon"
  MailCommand = "/usr/bin/bsmtp -h localhost -f \"(Bacula) <%r>\" -s \"Bacula daemon message\" %r"
  Mail = root@localhost = All, !Skipped
  Append = /var/log/bacula.log = All, !Skipped
  Console = All, !Skipped
}
Messages {
  Name = "Standard"
  MailCommand = "/usr/bin/bsmtp -h localhost -f \"(Bacula) <%r>\" -s \"Bacula: %t %e of %c %l\" %r"
  OperatorCommand = "/usr/bin/bsmtp -h localhost -f \"(Bacula) <%r>\" -s \"Bacula: Intervention needed for %j\" %r"
  Mail = root@localhost = All, !Skipped
  Append = /var/log/bacula.log = All, !Skipped
  Console = All, !Skipped
  Operator = root@localhost = Mount
  Catalog = All
}

### BCONSOLE ###
Console {
  Name = "bacula-mon"
  Password = "{{with secret "bacula/bacula-dir"}}{{.Data.data.password}}{{end}}"
  CommandAcl = "status"
  CommandAcl = ".status"
}

### JOBS ###
JobDefs {
  Name = "DefaultJob"
  Type = "Backup"
  Level = "Incremental"
  Messages = "Standard"
  Storage = "File1"
  Pool = "File"
  Fileset = "Full Set"
  Schedule = "WeeklyCycle"
  WriteBootstrap = "/usr/share/bacula/%c.bsr"
  SpoolAttributes = yes
  Priority = 10
}

Job {
  Name = "RestoreFiles"
  Type = "Restore"
  Messages = "Standard"
  Storage = "File1"
  Pool = "File"
  Client = "bacula-fd"
  Fileset = "Full Set"
  Where = "/tmp/bacula-restores"
}

#Job {
#  Name = "BackupClient1"
#  JobDefs = "DefaultJob"
#}    

@|"sh -c 'for f in /etc/bacula/jobs/*.conf ; do echo @${f} ; done'"

### CLIENTS ###

@|"sh -c 'for f in /etc/bacula/clients/*.conf ; do echo @${f} ; done'"
