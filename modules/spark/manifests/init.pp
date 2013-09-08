class spark {

  exec {"bigtop_repo":
    command => "wget -O /etc/yum.repos.d/bigtop.repo http://www.apache.org/dist/bigtop/bigtop-0.6.0/repos/centos6/bigtop.repo",
    unless => "ls /etc/yum.repos.d/bigtop.repo"
  }

  package {"bigtop-utils":
    ensure => present,
    require => Exec["bigtop_repo"]
  }

  exec {"install_spark":
    command => "yum install -y http://dev2.hortonworks.com.s3.amazonaws.com/stuff/rpms/spark-master-1.el6.noarch.rpm",
    unless => "ls /usr/lib/spark",
    require => Package["bigtop-utils"],
    timeout => 0
  }

}
