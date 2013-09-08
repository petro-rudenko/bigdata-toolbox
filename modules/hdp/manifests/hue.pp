class hdp::hue {
  include hdp::hdfs
  include hdp::yarn
  include hdp::hive

  line { "hdp_priority":
    file => "/etc/yum.repos.d/HDP.repo",
    line => "priority=-1"    
  }

  package {"yum-plugin-priorities":
    ensure => present,
  }
  
  package {"hue":
    ensure => present,
    require => [Line["hdp_priority"], Package["yum-plugin-priorities"]]
  }

  file {"/etc/hue/conf/hue.ini":
    source => "puppet:///modules/hdp/hue.ini",
    require => Package["hue"]
  }

  exec {"hue_start":
    command => "/etc/init.d/hue start",
    timeout => 0,
    require => [File["/etc/hue/conf/hue.ini"],Class["hdp::hive"], Class["hdp::hdfs"], Class["hdp::yarn"]]
  }
}
