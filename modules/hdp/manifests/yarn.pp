class hdp::yarn {

  exec {"resourcemanager_start":
    command => 'su - yarn -c  "export HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec && /usr/lib/hadoop-yarn/sbin/yarn-daemon.sh --config /etc/hadoop/conf start resourcemanager"',
    unless => "netstat -nan|grep 8088"
  }

  exec {"nodemanager_start":
    command => 'su - yarn -c  "export HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec && /usr/lib/hadoop-yarn/sbin/yarn-daemon.sh --config /etc/hadoop/conf start nodemanager"',
    unless => "ls /var/run/hadoop-yarn/yarn/yarn-yarn-nodemanager.pid"    
  }

  exec {"historyserver_start":
    command => 'su -l mapred -c  "export HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec && /usr/lib/hadoop-mapreduce/sbin/mr-jobhistory-daemon.sh --config /etc/hadoop/conf start historyserver"',
    unless => "ls /var/run/hadoop-mapreduce/mapred/mapred-mapred-historyserver.pid"
  }

}
