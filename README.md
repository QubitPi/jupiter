[ ![Docker](https://img.shields.io/badge/Docker%20Image-309DEE?style=for-the-badge&logo=docker&logoColor=white) ](https://hub.docker.com/r/jack20191124/druid)
[ ![License Badge](https://img.shields.io/badge/Apache%202.0-F25910.svg?style=for-the-badge&logo=Apache&logoColor=white) ](https://www.apache.org/licenses/LICENSE-2.0)
[ ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/QubitPi/jupiter/Druid%20CI/druid?logo=github&style=for-the-badge) ](https://github.com/QubitPi/jupiter/actions/workflows/druid-ci.yml)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/QubitPi/jupiter/druid?logo=github&style=for-the-badge)

Druid Docker Image
==================

![druid](https://user-images.githubusercontent.com/16126939/176320032-aaa07725-363e-4727-89a1-e4b86b2ec002.png)

Get Image
---------

### Docker Hub

You can pull the image from [my docker hub](https://hub.docker.com/r/jack20191124/druid/):

    docker pull jack20191124/druid

### GitHub

You could also build the image from [my source repository](https://github.com/QubitPi/jupiter/tree/druid/):

    git clone https://github.com/QubitPi/jupiter.git
    cd jupiter
    git checkout druid
    docker build -t jack20191124/druid .

Standup a Container
-------------------

Once image is on your machine(either by pulling or building), you can have an Druid instance in seconds. You can run in
2 modes:

### Interactive Mode

If you would like to spin up an Druid instance and interact with it using shell, run

    docker run --name=druid -it -p 8090:8090 -p 8081:8081 -p 8888:8888 jack20191124/druid /etc/druid-init.sh -bash

* Port 8888 is the Druid UI port

Once the cluster has started, you can navigate to http://localhost:8888. It takes a few seconds for all the Druid
processes to fully start up. If you open the console immediately after starting the services, you may see some errors
that you can safely ignore.

Play with Druid
---------------

### Loading Data

A data load is initiated by submitting an ingestion task spec to the Druid Overlord. 

An ingestion spec can be written by hand or by using the "Data loader" that is built into the Druid console. The data 
loader can help you build an ingestion spec by sampling your data and and iteratively configuring various ingestion 
parameters. The data loader currently only supports native batch ingestion.

See https://druid.apache.org/docs/latest/tutorials/tutorial-batch.html for loading data in this container.

License
-------

The use and distribution terms for this software are covered by the Apache License, Version 2.0
( http://www.apache.org/licenses/LICENSE-2.0.html ).
