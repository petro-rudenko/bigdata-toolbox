class accumulo {
  include hdp::zookeeper
  include hdp::hdfs

  exec {"install_accumulo":
    command => "yum install -y http://apache.cs.utah.edu/accumulo/1.5.0/accumulo-1.5.0-bin.rpm http://apache.cs.utah.edu/accumulo/1.5.0/accumulo-1.5.0-native.rpm",
    unless => "ls /opt/accumulo",
    require => Class["hdp::hdfs"]
  }

  exec {"copy_configs":
    command => "cp /opt/accumulo/accumulo-1.5.0/conf/examples/512MB/native-standalone/* /opt/accumulo/accumulo-1.5.0/conf/",
    unless => "ls /opt/accumulo/accumulo-1.5.0/conf/accumulo-site.xml",
    require => Exec["install_accumulo"]
  }

  file {"/opt/accumulo/accumulo-1.5.0/conf/accumulo-site.xml":
    source => "puppet:///modules/accumulo/accumulo-site.xml",
    require => Exec["copy_configs"]
  }

  file {"/opt/accumulo/accumulo-1.5.0/conf/accumulo-env.sh":
    source => "puppet:///modules/accumulo/accumulo-env.sh",
    require => Exec["copy_configs"]
  }

  file {"/opt/accumulo/accumulo-1.5.0/conf/monitor":
    source => "puppet:///modules/accumulo/monitor",
    require => Exec["copy_configs"]
  }

  exec {"prepare_hdfs":
    command => "su - hdfs -c 'hdfs dfs -mkdir /accumulo; hdfs dfs -chmod -R 777 /accumulo'",
    require => Class["hdp::hdfs"],
    logoutput => true
  }

  exec {"accumulo_init":
    command => "/opt/accumulo/accumulo-1.5.0/bin/accumulo init --instance-name sandbox.hortonworks.com --password hadoop --username root",
    require => [File["/opt/accumulo/accumulo-1.5.0/conf/monitor"],File["/opt/accumulo/accumulo-1.5.0/conf/accumulo-env.sh"],File["/opt/accumulo/accumulo-1.5.0/conf/accumulo-site.xml"], Exec["prepare_hdfs"], Class["hdp::zookeeper"]],
  }

  exec {"accumulo_start":
    command => "/bin/bash /opt/accumulo/accumulo-1.5.0/bin/start-all.sh",
    require => Exec["accumulo_init"]
  }

}
