Exec { path => [ "/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/", "/usr/local/bin" ] }

node default {
  include prepare
  include install
  include postinstall
}

node /^host[0-9]\.hortonworks\.com$/ {
  include prepare
  include install::ambari-agent
  include install::finish-cluster
  include postinstall::accumulo
}
