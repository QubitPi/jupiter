[ ![Docker](https://img.shields.io/badge/Docker%20Image-309DEE?style=for-the-badge&logo=docker&logoColor=white) ](https://hub.docker.com/r/jack20191124/hbase)
[ ![License Badge](https://img.shields.io/badge/Apache%202.0-F25910.svg?style=for-the-badge&logo=Apache&logoColor=white) ](https://www.apache.org/licenses/LICENSE-2.0)
[ ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/QubitPi/jupiter/HBase%20CI/hbase?logo=github&style=for-the-badge) ](https://github.com/QubitPi/jupiter/actions/workflows/hbase-ci.yml)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/QubitPi/jupiter/hbase?logo=github&style=for-the-badge)

Apache HBase Docker Image
=========================

![HBase Logo](https://user-images.githubusercontent.com/16126939/180642009-b6f44bda-bbdf-4c0f-a45e-d0c74214dfb4.png)

This image is used to quickly standup a HBase instance for various development purposes:

1. A pseudo-distributed HBase instance with minimum configurations. Pseudo-distributed mode means that HBase still runs 
   completely on a single host, but each HBase daemon (HMaster, HRegionServer, and ZooKeeper) runs as a separate
   process. **The data is stored in a real HDFS**.
2. Access HBase Web UI from host machine
3. Access HBase REST API endpoints
4. Interact with HBase from local host through HBase shell

Get Image
---------

### Docker Hub

You can pull the image from [my docker hub](https://hub.docker.com/r/jack20191124/hbase/):

    docker pull jack20191124/hbase

### GitHub

You could also build the image from [my source repository](https://github.com/QubitPi/jupiter/tree/hbase/):

    git clone https://github.com/QubitPi/jupiter.git
    cd jupiter
    git checkout hbase
    docker build -t jack20191124/hbase .

Standup a Container
-------------------

Once image is on your machine(either by pulling or building), you can run HBase in 2 modes:

### Non-Interactive Mode

If you would like to have an HBase that just runs forever, run

    docker run -it -p 16010:16010 -p 8080:8080 jack20191124/hbase /etc/hbase-init.sh -d
    
The port forwarding `16010:16010` allows you to access HBase Web UI from a local port. Another port forwarding
`8080:8080` gives you the ability to access REST endpoints

> Note that the HDFS port is set in the upstream
> [hadoop image, which is 8020](https://github.com/QubitPi/jupiter/blob/hadoop/core-site.xml). If its port number
> changes, this config change should also be applied in this image for `hbase.rootdir`, which points to the address of 
> HDFS instance, using the hdfs://// URI syntax. By default, HDFS is running on the localhost at
> [port 8020](https://github.com/QubitPi/jupiter/blob/hbase/hbase-site.xml).
> 
> ```xml
> <property>
>     <name>hbase.rootdir</name>
>     <value>hdfs://localhost:8020/hbase</value>
> </property>
> ```

### Interactive Mode

If you would like to spin up an HBase and interact with it using shell, run

    docker run -it -p 16010:16010 -p 8080:8080 jack20191124/hbase /etc/hbase-init.sh -bash

HBase Web UI
------------

Go to http://localhost:16010 to view the HBase Web UI. This is the quickest way to make sure that this container is 
working properly.

HBase Interactive Shell
-----------------------

In addition to being a local dev instance, this container automatically connects to `hbase shell` upon start. Here are 
some example commands for your to play with

Create a table:

    $HBASE_HOME/bin/hbase shell
    
    create "test", "cf"
    
The table created is called `test` with one column family `cf`. Now you can put data into the table:
    
    put "test", "row1", "cf:a", "value1"

Here we insert value `value1` into row `row1` at column `cf:a`. Columns in HBase are comprised of a column family
prefix, `cf` in this example, followed by a colon and then a column qualifier suffix, `a` in this case.

Scan the table for all data at once:

    scan "test"
    
Get a single row of data:

    get "test", "row1"

If you want to delete a table or change its settings, as well as in some other situations, you need to disable the table 
first:

    disable "test"
    
Drop the table:

    drop "test"
    
HBase REST API
--------------

You can experiment with HBase REST API by taking the example request from
https://hbase.apache.org/book.html#_using_rest_endpoints . Replace `example.com:8000` with `localhost:8080`.

License
-------

The use and distribution terms for this software are covered by the Apache License, Version 2.0
(http://www.apache.org/licenses/LICENSE-2.0.html).
