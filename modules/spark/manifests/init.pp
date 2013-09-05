class spark {

  exec {"install_spark":
    command => "yum install -y http://dev2.hortonworks.com.s3.amazonaws.com/stuff/rpms/spark-master-1.el6.noarch.rpm",
    unless => "ls /usr/lib/spark"
  }

}
