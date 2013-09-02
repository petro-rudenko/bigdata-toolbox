# Big Data toolbox

Vagrant VM with preinstalled [HDP2 Stack](http://hortonworks.com/products/hdp/hdp2/) and additional big data software/libs.

## What's inside:

Hadoop [HDP2 stack](http://hortonworks.com/products/hdp/hdp2/):
- [x] Hadoop (HDFS, YARN, MapReduce2) 2.1.0
- [x] Pig (0.11.1)
- [x] Hive/Hcatalog (0.11.0)
- [x] Oozie (4.0)
- [x] Hbase (0.95.2)
- [x] Zookeeper(3.4.5)
- [x] Ambari (1.4.0)

Stream processing tools: 
- [x] Strom (0.8.2)
- [ ] Strom on yarn **TODO**

Interactive query tools:
- [ ] Spark (0.7.3) **TODO**
- [ ] Tez **TODO**

Nosql:
- [ ] Cassandra **TODO**
- [ ] GraphDB: Aurelius (or Neo4J) **TODO**


## How to install:
* Install latest [Vagrant](http://www.vagrantup.com/)

```
   $ git clone https://github.com/petro-rudenko/bigdata-toolbox.git && cd bigdata-toolbox
   $ vagrant up
```

## Choose what services to install/run:
Edit manifests and comment services that you don't wan to run.

