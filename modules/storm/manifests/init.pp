class storm {
  include hdp::zookeeper
  
  package{ "uuid":
    ensure => "present"
  }

  file{"/tmp/install_storm.sh":
    source => "puppet:///modules/storm/install_storm.sh"
  }


  exec { "install_storm":
    command => "/bin/bash /tmp/install_storm.sh",
    creates => "/opt/storm/storm*.jar",
    logoutput => true,
    timeout => 0,
    require => [Package["uuid"], File["/tmp/install_storm.sh"]]
  }

  file { "/opt/storm/conf/storm.yaml":
    source => "puppet:///modules/storm/storm.yaml",
    require => Exec["install_storm"]
  }

  exec { "storm-nimbus-start":
    command => "service storm-nimbus start",
    require => [File["/opt/storm/conf/storm.yaml"], Class["hdp::zookeeper"]]
  }

  exec { "storm-ui-start":
    command => "service storm-ui start",
    require => [File["/opt/storm/conf/storm.yaml"], Exec["storm-nimbus-start"]]
  }

  exec { "storm-supervisor-start":
    command => "service storm-supervisor start",
    require => [File["/opt/storm/conf/storm.yaml"], Exec["storm-nimbus-start"]]
  }  
  
}
