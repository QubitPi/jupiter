[ ![Docker](https://img.shields.io/badge/Docker%20Image-309DEE?style=for-the-badge&logo=docker&logoColor=white) ](https://hub.docker.com/r/jack20191124/zookeeper)
[ ![License Badge](https://img.shields.io/badge/Apache%202.0-F25910.svg?style=for-the-badge&logo=Apache&logoColor=white) ](https://www.apache.org/licenses/LICENSE-2.0)
[ ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/QubitPi/jupiter/ZooKeeper%20CI/zookeeper?logo=github&style=for-the-badge) ](https://github.com/QubitPi/jupiter/actions/workflows/zookeeper-ci.yml)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/QubitPi/jupiter/zookeeper?logo=github&style=for-the-badge)

ZooKeeper Docker Image
======================

![apache-logo](https://user-images.githubusercontent.com/16126939/176544349-0cb18331-158a-4d27-88c2-b47a6326ab0c.png)

Get Image
---------

### Docker Hub

You can pull the image from [my docker hub](https://hub.docker.com/r/jack20191124/zookeeper/):

    docker pull jack20191124/zookeeper

### GitHub

You could also build the image from [my source repository](https://github.com/QubitPi/jupiter/tree/zookeeper/):

    git clone https://github.com/QubitPi/jupiter.git
    cd jupiter
    git checkout zookeeper
    docker build -t jack20191124/zookeeper .

Standup a Container
-------------------

Once image is on your machine(either by pulling or building), you can have a ZooKeeper instance quickly in 2 modes:

### Non-Interactive Mode

If you would like to have a ZooKeeper instance that just runs forever, run

    docker run -d --name=zookeeper -p 2181:2181 -it jack20191124/zookeeper /etc/init.sh -d

### Interactive Mode

If you would like to spin up a ZooKeeper and interact with it using shell, run

    docker run --name=zookeeper -it -p 2181:2181 jack20191124/zookeeper /etc/init.sh -bash

License
-------

The use and distribution terms for this software are covered by the Apache License, Version 2.0
( http://www.apache.org/licenses/LICENSE-2.0.html ).
