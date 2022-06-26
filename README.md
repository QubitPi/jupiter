[ ![Docker](https://img.shields.io/badge/Docker%20Image-309DEE?style=for-the-badge&logo=docker&logoColor=white) ](https://hub.docker.com/r/jack20191124/redis)
[ ![License Badge](https://img.shields.io/badge/Apache%202.0-F25910.svg?style=for-the-badge&logo=Apache&logoColor=white) ](https://www.apache.org/licenses/LICENSE-2.0)
[ ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/QubitPi/jupiter/Redis%20CI/redis?logo=github&style=for-the-badge) ](https://github.com/QubitPi/jupiter/actions/workflows/redis-ci.yml)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/QubitPi/jupiter/redis?logo=github&style=for-the-badge)

Docker Image for Local-Mode Redis
=================================

![Redis Logo](https://drive.google.com/uc?id=1h6q2bpDf8gYveETCIkFtOXXx2pKpCwfO)

Docker image for Redis running locally(non-distributed mode). This is used to quickly standup a Redis instance for 
development purposes. It could also be deployed to production environment for caching facility.

Many enterprise-scale cloud applications sit on machines that provides sufficient memory to store some whole set of
caching data. This makes Redis a very good candidate for caching.

Redis is an open source, in-memory data structure store, used as a database, cache, and message broker. It supports data 
structures such as strings, hashes, lists, sets, sorted sets with range queries, bitmaps, hyperloglogs, and geospatial 
indexes with radius queries. Redis has built-in replication, Lua scripting, LRU eviction, transactions and different
levels of on-disk persistence, and provides high availability via Redis Sentinel and automatic partitioning with Redis 
Cluster.

Compared to [memcached](https://memcached.org/), Redis

* supports the writing of its data to disk automatically in 2 different ways
* can store data in 4 structures in addition to plain string keys
* is used widely either as a primary database or as an auxiliary cache with other storage systems

Get Image
---------

### Docker Hub

You can pull the image from [my docker hub](https://hub.docker.com/r/jack20191124/redis/):

    docker pull jack20191124/redis

### GitHub

You could also build the image from [my source repository](https://github.com/QubitPi/jupiter/tree/redis/):

    git clone https://github.com/QubitPi/jupiter.git
    cd jupiter
    git checkout redis
    docker build -t jack20191124/redis .

Standup a Container
-------------------

Once image is on your machine(either by pulling or building), you can standup a Redis instance.

### Production Environment

    docker run -it -d -p 6379:6379 jack20191124/redis /etc/init.sh true

### Non-production Environment

    docker run -it -p 6379:6379 jack20191124/redis /etc/init.sh

or

    docker run -it -p 6379:6379 jack20191124/redis /etc/init.sh false

Non-production container will end up taking you to a Redis command line environment so that you could issue any
convenient Redis command against the container.

License
-------

The use and distribution terms for this software are covered by the Apache License, Version 2.0
(http://www.apache.org/licenses/LICENSE-2.0.html).
