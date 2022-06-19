[ ![Docker](https://img.shields.io/badge/Docker%20Image-309DEE?style=for-the-badge&logo=docker&logoColor=white) ](https://hub.docker.com/r/jack20191124/hadoop)
[![License Badge](https://img.shields.io/badge/Apache%202.0-F25910.svg?style=for-the-badge&logo=Apache&logoColor=white) ](https://www.apache.org/licenses/LICENSE-2.0)
[ ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/QubitPi/jupiter/Hadoop%20CI/hadoop?logo=github&style=for-the-badge) ](https://github.com/QubitPi/jupiter/actions/workflows/hadoop-ci.yml)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/QubitPi/jupiter/hadoop?logo=github&style=for-the-badge)

Hadoop Docker Image
===================

![Hadoop Logo](https://user-images.githubusercontent.com/16126939/180641285-1ff7ea05-609a-485a-9f08-519a33571fdb.png)

This image can be used

1. for quick provisioning of real HDFS for Hadoop-related functional tests, and
2. as a base image of other Hadoop-based distributed systems, such as
   [HBase](https://hub.docker.com/r/jack20191124/hbase/).

Specifically, the image offers the following features:

* **Real interactive HDFS**: You could access Hadoop cluster UI, execute all HDFS related commands(e.g.
  `hdfs dfs -ls /`), and run MapReduce jobs just like in a real Hadoop cluster.
* **Easier debugging**: At any point of integration tests, developer could examine the state of the HDFS, which gives 
  them great insights on the code behaviors.
* **Java API**: This image has complete support for integration tests that access HDFS via its Java API. An example 
  snippet is provided below.
* **Support HttpFS**: Wanna talk to HDFS via proxy or something else other than Java API? Not a problem, this images
  opens HttpFS for you!
* **Extensible Image**: Designed as a base image for all Hadoop-based systems, such as
  [HBase](https://hub.docker.com/r/jack20191124/hbase/).

Get Image
---------

### Docker Hub

You can pull the image from [my docker hub](https://hub.docker.com/r/jack20191124/hadoop/):

    docker pull jack20191124/hadoop

### GitHub

You could also build the image from [my source repository](https://github.com/QubitPi/jupiter/tree/hadoop/):

    git clone https://github.com/QubitPi/jupiter.git
    cd jupiter
    git checkout hadoop
    docker build -t jack20191124/hadoop .

Standup a Container
-------------------

When image is on your machine (either by pulling or building), you can spin up a HDFS instance in 2 modes:

### Non-Interactive Mode

If you would like to have a HDFS that just runs forever, run

    docker run -d --name=hdfs -it \
        -p 8020:8020 \
        -p 50070:50070 \
        -p 50090:50090 \
        -p 50091:50091 \
        -p 50010:50010 \
        -p 50075:50075 \
        -p 50020:50020 \
        -p 14000:14000 \
        jack20191124/hadoop /etc/init.sh -d

* **name=hdfs**: the container is named "hdfs". You can change it accordingly.
* **-p 50070:50070**: 50070 is the base port where the dfs namenode web UI will listen on. With this port forwarding,
  you will be able to access namenode web UI from host machine web browser at `localhost:50070`
* **-p 8020:8020 -p 50090:50090 -p 50091:50091 -p 50010:50010 -p 50075:50075 -p 50020:50020**: allow Java API to access 
  HDFS. **This made the container very useful if you are running some integration tests using this image. You are 
  essentially testing against a real HDFS instead of mocked object**
* **-p 14000:14000**: allow host to access HttpFS
* **-d**: two `-d`s(one after `docker run`; one at the end) keep container running in background after start

#### NameNode UI

Browse the web interface for the NameNode; by default it is available at http://localhost:50070/

This is the quickest way to make sure that this container is working properly.

### Interactive Mode

If you would like to spin up a HDFS and interact with it using shell, run

    docker run --name=hdfs -it \
        -p 8020:8020 \
        -p 50070:50070 \
        -p 50090:50090 \
        -p 50091:50091 \
        -p 50010:50010 \
        -p 50075:50075 \
        -p 50020:50020 \
        -p 14000:14000 \
        jack20191124/hadoop /etc/init.sh -bash

With interactive mode, you could deploy and run MapReduce Job through shell commands; an example MapReduce job below is 
for you to try out.

> 📋️ When you exit container by 'exit', the container will stop immediately

#### Execute an Example MapReduce Job

If you are running container in interactive mode, you can play with this example.

Make the HDFS directories required to execute MapReduce jobs:

    hdfs dfs -mkdir /user
    hdfs dfs -mkdir -p /user/root

Copy the input files into the distributed filesystem:

    hdfs dfs -put $HADOOP_HOME/etc/hadoop input

Run the examples provided:

    $HADOOP_HOME/bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-<version>.jar grep input output 'dfs[a-z.]+'
    
Note that `<version>` is the version of hadoop, e.g. `2.8.4`.

Examine the output files: Copy the output files from the distributed filesystem to the local filesystem and examine
them:

    hdfs dfs -get output output
    cat output/*

or, View the output files on the distributed filesystem:

    hdfs dfs -cat output/*

JVM API
-------

Let's say you wrote a HDFS client and would like to test it. Your client passed unit tests via mocking. Now you can test 
the client against a real HDFS during integration tests with this image. Here is a Groovy example:

<img width="920" alt="jvm-api" src="https://user-images.githubusercontent.com/16126939/179653433-91bcda63-e5cc-4669-bb24-3ce764643c15.png">

This images runs container as `root` user. You should always send API calls as root user. User-spaced integration tests 
might be supported in future release.

`hdfs://localhost:8020/` means we, as host, are accessing HDFS from localhost at port 8020. The port forwarding of `-p 
8020:8020` maps `localhost:8020` to `container:8020`. You can always use the same `localhost:8020` in integration tests. 
This is a consistency advantage that this images gives to you.

HttpFS
------

Your team might have proxy in front of Hadoop cluster and you shall access HDFS via proxy's REST HTTP endpoints. This 
image allows you to write integration tests for this situation.

To demonstrate, spinup a container in interactive mode and create some files by executing the following commands in the 
container:

    hdfs dfs -mkdir -p /user/root
    hdfs dfs -put $HADOOP_HOME/etc/hadoop input

Now you have some files in HDFS under some path. Your integration tests can access them via `curl` or HTTP API in your 
programming language. Here is how we do it via `curl`:

    curl "http://localhost:14000/webhdfs/v1/user/root/input/core-site.xml?op=open&user.name=root"

Note that you access the files from your host machine because that's where you integration tests are ;)

License
-------

The use and distribution terms for this software are covered by the Apache License, Version 2.0 ( http://www.apache.
org/licenses/LICENSE-2.0.html ).
