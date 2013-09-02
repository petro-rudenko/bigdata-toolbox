class hdp::hdfs{

  exec {"start_namenode":
    command => 'su - hdfs -c "export HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec && /usr/lib/hadoop/sbin/hadoop-daemon.sh --config /etc/hadoop/conf start namenode";'
  }

  exec {"start_datanode":
    command => 'su - hdfs -c "export HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec && /usr/lib/hadoop/sbin/hadoop-daemon.sh --config /etc/hadoop/conf start datanode;"'
  }

  exec {"start_snn":
    command => 'su - hdfs -c  "export HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec && /usr/lib/hadoop/sbin/hadoop-daemon.sh --config /etc/hadoop/conf start secondarynamenode";'
  }
  
}
