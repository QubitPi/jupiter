[ ![Docker](https://img.shields.io/badge/Docker%20Image-309DEE?style=for-the-badge&logo=docker&logoColor=white) ](https://hub.docker.com/r/jack20191124/chef)
[ ![License Badge](https://img.shields.io/badge/Apache%202.0-F25910.svg?style=for-the-badge&logo=Apache&logoColor=white) ](https://www.apache.org/licenses/LICENSE-2.0)
[ ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/QubitPi/jupiter/CHEF%20CI/chef?logo=github&style=for-the-badge) ](https://github.com/QubitPi/jupiter/actions/workflows/chef-ci.yml)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/QubitPi/jupiter/chef?logo=github&style=for-the-badge)

Chef Docker Image
=================

![CHEF Logo](https://user-images.githubusercontent.com/16126939/176977885-e750fd30-12ca-45af-b517-30c486b06992.png)

Get Image
---------

### Docker Hub

You can pull the image from [my docker hub](https://hub.docker.com/r/jack20191124/chef/):

    docker pull jack20191124/chef

### GitHub

You could also build the image from [my source repository](https://github.com/QubitPi/jupiter/tree/chef/):

    git clone https://github.com/QubitPi/jupiter.git
    cd jupiter
    git checkout chef
    docker build -t jack20191124/chef .

Standup a Container
-------------------

Once image is on your machine(either by pulling or building), you can start a Chef container by

    docker run --name=chef -it jack20191124/chef /bin/bash

Cooking inside Container
------------------------

TBD

License
-------

The use and distribution terms for this software are covered by the Apache License, Version 2.0
( http://www.apache.org/licenses/LICENSE-2.0.html ).
