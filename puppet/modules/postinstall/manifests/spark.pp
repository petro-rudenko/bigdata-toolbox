class postinstall::spark{

  package{"redhat-lsb":
    ensure => installed
  }
  
  package{"spark-core":
    provider => rpm, 
    ensure => installed,
    source => "http://public-repo-1.hortonworks.com/spark/centos6/rpms/spark-core-0.9.1.2.1.1.0-22.el6.noarch.rpm",
    require => Package["redhat-lsb"]
  }

  package{"spark-python":
    provider => rpm, 
    ensure => installed,
    source => "http://public-repo-1.hortonworks.com/spark/centos6/rpms/spark-python-0.9.1.2.1.1.0-22.el6.noarch.rpm",
    require => Package["spark-core"]
  }
  
}
