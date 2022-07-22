[ ![Docker](https://img.shields.io/badge/Docker%20Image-309DEE?style=for-the-badge&logo=docker&logoColor=white) ](https://hub.docker.com/r/jack20191124/opentsdb)
[ ![License Badge](https://img.shields.io/badge/Apache%202.0-F25910.svg?style=for-the-badge&logo=Apache&logoColor=white) ](https://www.apache.org/licenses/LICENSE-2.0)
[ ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/QubitPi/jupiter/OpenTSDB%20CI/opentsdb?logo=github&style=for-the-badge) ](https://github.com/QubitPi/jupiter/actions/workflows/opentsdb-ci.yml)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/QubitPi/jupiter/opentsdb?logo=github&style=for-the-badge)

OpenTSDB Docker Image
=====================

![OpenTSDB Logo](https://user-images.githubusercontent.com/16126939/180417939-e412d0a4-bff6-4d62-b6d2-de0a01c6694b.png)

OpenTSDB is a scalable time series database. This image spins up an OpenTSDB instance for development purposes. The
image offers all features of an OpenTSDB in production. The container of this image runs on top of a pseudo-distributed 
[HBase](https://hub.docker.com/r/jack20191124/hbase/) instance, which is on top of a pseudo-distributed
[HDFS](https://hub.docker.com/r/jack20191124/hadoop/).

Get Image
---------

### Docker Hub

You can pull the image from [my docker hub](https://hub.docker.com/r/jack20191124/opentsdb/):

    docker pull jack20191124/opentsdb

### GitHub

You could also build the image from [my source repository](https://github.com/QubitPi/jupiter/tree/opentsdb/):

    git clone https://github.com/QubitPi/jupiter.git
    cd jupiter
    git checkout opentsdb
    docker build -t jack20191124/opentsdb .

Standup a Container
-------------------

Once image is on your machine(either by pulling or building), you can have an OpenTSDB instance in seconds. You can run
in 2 modes:

### Interactive Mode

If you would like to spin up an OpenTSDB instance and interact with it using shell, run

    docker run --name=opentsdb -it -p 4242:4242 jack20191124/opentsdb /etc/opentsdb-init.sh -bash
    
I suggest you run it in interactive mode if you would like to
[play with the container a little more](#quick-start-using-the-container) ("Quick Start Using the Container" below).

### Non-Interactive Mode

If you would like to have it run forever:

    docker run -d --name=opentsdb -it -p 4242:4242 jack20191124/opentsdb /etc/opentsdb-init.sh -d
    
Quick Start Using the Container
-------------------------------

Once you have the container up and running, you can follow the steps below to get some data into OpenTSDB. After you
have some data stored, pull up the GUI and try generating some graphs.

### Create Your First Metrics

Metrics need to be registered before you can start storing data points for them. This helps to avoid ingesting unwanted 
data and catch typos. You can enable auto-metric creation via configuration. To register one or more metrics, call the 
mkmetric CLI inside the container:

    $OPENTSDB_HOME/build/tsdb mkmetric source.metric_a source.metric_b
    
This will create 2 metrics: `source.metric_a` and `source.metric_b`

### Inject Data

There are multiple ways to store data. We will do this using HTTP API on the host machine.
 
You can supply a single data point or multiple data points encased in an array in a request. Let's put multiple data 
points so we can see something in

```json
[
    {
        "metric": "source.metric_a",
        "timestamp": 1538104216,
        "value": 9,
        "tags": {
           "host": "web01",
           "dc": "lga"
        }
    },
    {
        "metric": "source.metric_a",
        "timestamp": 1538104316,
        "value": 18,
        "tags": {
           "host": "web01",
           "dc": "lga"
        }
    },
    {
        "metric": "source.metric_a",
        "timestamp": 1538104416,
        "value": 21,
        "tags": {
           "host": "web02",
           "dc": "lga"
        }
    }
]
```

Save the JSON above in a file called `data.json` and POST it to the following endpoint:

    curl -X POST localhost:4242/api/put -d @data.json

### Visualize Data on UI

Visit localhost:4242 on your host machine browser and query the metric for the timestamp range you just posted

License
-------

The use and distribution terms for this software are covered by the Apache License, Version 2.0
( http://www.apache.org/licenses/LICENSE-2.0.html ).
