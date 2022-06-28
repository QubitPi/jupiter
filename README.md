[ ![Docker](https://img.shields.io/badge/Docker%20Image-309DEE?style=for-the-badge&logo=docker&logoColor=white) ](https://hub.docker.com/r/jack20191124/drill)
[ ![License Badge](https://img.shields.io/badge/Apache%202.0-F25910.svg?style=for-the-badge&logo=Apache&logoColor=white) ](https://www.apache.org/licenses/LICENSE-2.0)
[ ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/QubitPi/jupiter/Drill%20CI/drill?logo=github&style=for-the-badge) ](https://github.com/QubitPi/jupiter/actions/workflows/drill-ci.yml)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/QubitPi/jupiter/drill?logo=github&style=for-the-badge)

Docker Image for Apache Drill on Hadoop & HBase
===============================================

![Apache Drill Logo](https://user-images.githubusercontent.com/16126939/176206237-1354d2dc-c816-4a44-8ce9-724cbab552b9.png)

This image is used to quickly standup a Drill instance for development purposes. The features of this image include

* Runs on alongside with a single-node ZooKeeper
* The container runs on top of a real HBase instance, which is operating in a real HDFS.
* Optimized for quick provisioning of Drill integration tests

Get Image
---------

### Docker Hub

You can pull the image from [my docker hub](https://hub.docker.com/r/jack20191124/drill/):

    docker pull jack20191124/drill

### GitHub

You could also build the image from [my source repository](https://github.com/QubitPi/jupiter/tree/drill/):

    git clone https://github.com/QubitPi/jupiter.git
    cd jupiter
    git checkout drill
    docker build -t jack20191124/drill .

Standup a Container
-------------------

**It is recommended to assign at least 4GB of memory to container of this image. It has been observed that about 2GB of 
memory is consumed upon container startup, because this container will also construct HDFS, HBase, and ZooKeeper
alongside with Drill.**

Once image is on your machine(either by pulling or building), you can standup a Drill instance in distributed mode by

    docker run -it -p 8047:8047 -p 2181:2181 jack20191124/drill /etc/drill-init.sh -bash

The port forwarding of `-p 8047:8047` enables you to access Drill UI from localhost. `-p 2181:2181` is for JDBC
connection to ZooKeeper.

### Query HBase through Drill

1. Enable [HBase Storage Plugin](https://drill.apache.org/docs/hbase-storage-plugin/)
2. [Create HBase table and insert testing data](https://drill.apache.org/docs/querying-hbase/#create-the-hbase-tables)
   in container. **Please replace `hbase shell` with `$HBASE_HOME/bin/hbase shell`**.
3. In [Drill console](localhost:8047), go to "Query" tab and issue the query `SELECT * FROM hbase.clicks`

License
-------

The use and distribution terms for this software are covered by the Apache License, Version 2.0
(http://www.apache.org/licenses/LICENSE-2.0.html).
