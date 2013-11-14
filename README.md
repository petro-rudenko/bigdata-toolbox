# Big Data toolbox

Vagrant VM with preinstalled [HDP2 Stack](http://hortonworks.com/products/hdp/hdp2/) and additional big data software/libs.

## What's inside:

Hadoop [HDP2 stack](http://hortonworks.com/products/hdp/hdp2/):
- [x] Hadoop (HDFS, YARN, MapReduce2) 2.2.0
- [x] Pig (0.12)
- [x] Hive/Hcatalog (0.12)
- [x] Oozie (4.0)
- [x] Hbase (0.96)
- [x] Zookeeper (3.4.5)
- [x] Hue (2.3.0)
- [x] Ambari (1.4.1)

Stream processing tools: 
- [x] Strom (0.8.2)
- [ ] Strom on yarn **TODO**

Interactive query tools:
- [x] Spark (0.8.0) (*Spark was compiled with SPARK_HADOOP_VERSION=2.0.5-alpha. It's incompatible with hadoop2.2.0 installed on toolbox* See https://github.com/apache/incubator-spark/pull/141)
- [ ] Tez **TODO**

Nosql:
- [ ] Cassandra **TODO**
- [ ] GraphDB: Aurelius (or Neo4J) **TODO**
- [x] Accumulo (1.5.0)

## How to install:
* Install latest [Vagrant](http://www.vagrantup.com/)

```
   $ git clone https://github.com/petro-rudenko/bigdata-toolbox.git && cd bigdata-toolbox
   $ vagrant up
```

## Choose what services to install/run:
Edit manifests and comment services that you don't wan to run.

