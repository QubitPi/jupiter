[ ![Docker](https://img.shields.io/badge/Docker%20Image-309DEE?style=for-the-badge&logo=docker&logoColor=white) ](https://hub.docker.com/r/jack20191124/jenkins)
[ ![License Badge](https://img.shields.io/badge/Apache%202.0-F25910.svg?style=for-the-badge&logo=Apache&logoColor=white) ](https://www.apache.org/licenses/LICENSE-2.0)
[ ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/QubitPi/jupiter/Jenkins%20CI/jenkins?logo=github&style=for-the-badge) ](https://github.com/QubitPi/jupiter/actions/workflows/jenkins-ci.yml)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/QubitPi/jupiter/jenkins?logo=github&style=for-the-badge)

Jenkins Docker Image
====================

![Jenkins Logo](https://user-images.githubusercontent.com/16126939/177018846-540d7d55-b7a7-48e3-976a-f7a438c04297.png)

Get Image
---------

### Docker Hub

You can pull the image from [my docker hub](https://hub.docker.com/r/jack20191124/jenkins/):

    docker pull jack20191124/jenkins

### GitHub

You could also build the image from [my source repository](https://github.com/QubitPi/jupiter/tree/jenkins/):

    git clone https://github.com/QubitPi/jupiter.git
    cd jupiter
    git checkout jenkins
    docker build -t jack20191124/jenkins .

Standup a Container
-------------------

Once image is on your machine(either by pulling or building), you can have a HDFS in seconds. You can have HDFS in 2 modes:

### Non-Interactive Mode

If you would like to have a Jenkins server that just runs forever, run

    docker run -d --name=jenkins -it -p 8080:8080 jack20191124/jenkins /etc/init.sh -d

* **name=jenkins**: the container is named "jenkins". You can change it to a different name.
* **-d**: two `-d`s(one after `docker run`; one at the end) keep container running in background after start

### Interactive Mode

If you would like to spin up a Jenkins and interact with it using shell, run

    docker run --name=jenkins -it -p 8080:8080 jack20191124/jenkins /etc/init.sh -bash

Use the Container
-----------------

Hit http://localhost:8080 from browser on host machine and follow the instructions to complete the installation.

License
-------

The use and distribution terms for this software are covered by the Apache License, Version 2.0 ( http://www.apache.org/licenses/LICENSE-2.0.html ).
