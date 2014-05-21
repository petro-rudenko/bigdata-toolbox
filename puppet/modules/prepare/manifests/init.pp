class prepare{

  package{"java":
    name => "java-1.7.0-openjdk-devel",
    ensure => installed
  }
  
  # package{'java':
  #   provider => rpm, 
  #   ensure => installed,
  #   source => "http://dev2.hortonworks.com.s3.amazonaws.com/ARTIFACTS/jdk-7u51-linux-x64.rpm"    
  # }

  $iptable = ["iptables", "ip6tables"]
  
  service {$iptables:
    enable => false,
    ensure => "stopped"
  }

  package {'wget':
    ensure => installed
  }

  exec{'set_javahome':    
    command => "echo 'export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk.x86_64; export PATH=\$JAVA_HOME/bin:\$PATH' > /etc/profile.d/java.sh;",
    require => Package['java']
  }
  
}
