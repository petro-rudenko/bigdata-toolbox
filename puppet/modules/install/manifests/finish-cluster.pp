class install::finish-cluster {
  
  #Blocker for slaves to wait for cluster to be ready
  exec {"Finish cluster":
    command => "/bin/bash check_status.sh",
    cwd => "/tmp/puppet/modules/install/files",
    timeout => 0,
    logoutput => true,
    require => Class["install::ambari-agent"]
  }


}
