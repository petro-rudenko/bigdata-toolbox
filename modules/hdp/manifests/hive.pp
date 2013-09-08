class hdp::hive {
  
  service {"mysqld":
    ensure => running
  } 

  exec {"start_hive_metastore":
    command => "su -  -c  'env HADOOP_HOME=/usr JAVA_HOME=/usr/jdk/jdk1.6.0_31 /tmp/startMetastore.sh /var/log/hive/hive.out /var/log/hive/hive.log /var/run/hive/hive.pid /etc/hive/conf.server '",
    require => Service["mysqld"]
  }

  exec {"start_hiveserver2":
    command => "su -  -c  'env JAVA_HOME=/usr/jdk/jdk1.6.0_31 /tmp/startHiveserver2.sh /var/log/hive/hive-server2.out  /var/log/hive/hive-server2.log /var/run/hive/hive-server.pid /etc/hive/conf.server '",
    require => Exec["start_hive_metastore"]
  }

  exec {"start_webhdfs":
    command => 'su - hcat -c "/usr/lib/hcatalog/sbin/webhcat_server.sh start"',
    require => Exec["start_hive_metastore"]
  }
}
