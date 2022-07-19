[ ![Docker](https://img.shields.io/badge/Docker%20Image-309DEE?style=for-the-badge&logo=docker&logoColor=white) ](https://hub.docker.com/r/jack20191124/faban)
[ ![License Badge](https://img.shields.io/badge/Apache%202.0-F25910.svg?style=for-the-badge&logo=Apache&logoColor=white) ](https://www.apache.org/licenses/LICENSE-2.0)
[ ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/QubitPi/jupiter/Faban%20CI/faban?logo=github&style=for-the-badge) ](https://github.com/QubitPi/jupiter/actions/workflows/faban-ci.yml)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/QubitPi/jupiter/faban?logo=github&style=for-the-badge)

Faban Docker Image
==================

<img src="./faban-logo.png" width="256">

[Faban](http://faban.org/) is a free and open source performance workload creation and execution framework.

Faban is used in performance, scalability and load testing of almost any type of server application. If the application 
accepts requests on a network, Faban can measure it.

Get Image
---------

### Docker Hub

You can pull the image from [my docker hub](https://hub.docker.com/r/jack20191124/faban/):

    docker pull jack20191124/faban

### GitHub

You could also build the image from [my source repository](https://github.com/QubitPi/jupiter/tree/faban/):

    git clone https://github.com/QubitPi/jupiter.git
    cd jupiter
    git checkout faban
    docker build -t jack20191124/faban .

Standup a Container
-------------------

Once image is on your machine(either by pulling or building), you can have a Faban instance in seconds. You can run in 2 modes:

### Non-Interactive Mode

If you would like to have it run forever:

    docker run -d --name=jack20191124/faban -it -p 9980:9980 jack20191124/faban /etc/init.sh -d

### Interactive Mode

If you would like to spin up a HDFS and interact with it using shell, run

    docker run --name=faban -it -p 9980:9980 jack20191124/faban /etc/init.sh -bash

Point your browser to the host on which you started Faban using port 9980. You should see the following:

![](http://faban.org/images/fabanhome.png)

License
-------

The use and distribution terms for this software are covered by the Apache License, Version 2.0
( http://www.apache.org/licenses/LICENSE-2.0.html ).
