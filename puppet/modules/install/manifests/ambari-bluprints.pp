class install::ambari-bluprints{

  if $nodecount==3{
    if $stack == 'gluster' {
      exec{"register correct stack":
        command => "curl -H 'X-Requested-By: ambari' -u admin:admin  -X PUT -d {\"Repositories\":{\"base_url\":\"http://dev.hortonworks.com.s3.amazonaws.com/HDP/centos6/2.x/updates/2.2.0.0/\"}}  http://ambari.hortonworks.com:8080/api/v1/stacks/HDP/versions/2.1.GlusterFS/operating_systems/redhat6/repositories/HDP-2.1.GlusterFS",
        require => Class["install::ambari-server"]
      }      
      file{"/tmp/install/bluprint.json":
        source => "puppet:///modules/install/bluprint-gluster-3-nodes.json",
        require => Exec["register correct stack"]
      }
    }
    else {
      file{"/tmp/install/bluprint.json":
        source => "puppet:///modules/install/bluprint-3-nodes.json"
      }
    }
    file{"/tmp/install/cluster.json":
      source => "puppet:///modules/install/3-nodes-bluprint-cluster.json"
    }    
  } 
  else {
    file{"/tmp/install/bluprint.json":
      source => "puppet:///modules/install/bluprint-1-nodes.json"
    }
    file{"/tmp/install/cluster.json":
      source => "puppet:///modules/install/1-nodes-bluprint-cluster.json"
    }
  }

  file{"/tmp/install/check_status.py":
    source => "puppet:///modules/install/check_status.py" 
  }

  file{"/tmp/install/check_status.sh":
    source => "puppet:///modules/install/check_status.sh" 
  }

  exec {"add bluprint":
    command => "curl -f -H 'X-Requested-By: ambari' -u admin:admin http://ambari.hortonworks.com:8080/api/v1/blueprints/sandbox -d @/tmp/install/bluprint.json",
    require => [File["/tmp/install/bluprint.json"],Class["install::ambari-server"]],
    logoutput => true
  }

  exec {"add cluster":
    command => "curl -f -H 'X-Requested-By: ambari' -u admin:admin http://ambari.hortonworks.com:8080/api/v1/clusters/Sandbox -d @/tmp/install/cluster.json",
    require => [File["/tmp/install/cluster.json"],Exec["add bluprint"]],
    logoutput => true
  }

  exec {"install cluster":
    command => "/bin/bash /tmp/install/check_status.sh",
    cwd => "/tmp/install",
    timeout => 0,
    logoutput => true,
    require => [File["/tmp/install/check_status.py"], File["/tmp/install/check_status.sh"], Exec["add cluster"]]
  }
  
}
