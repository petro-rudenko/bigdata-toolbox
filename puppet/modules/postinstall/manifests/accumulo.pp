class postinstall::accumulo{
  
  if $role == 'ambari' {
    include install::ambari-bluprints
    package{"accumulo":
      ensure => installed,
      require => Class["install::ambari-bluprints"]
    }
  } 
  else {
    include install::finish-cluster
    package{"accumulo":
      ensure => installed,
      require => Class["install::finish-cluster"]
    }
  }
  

}
