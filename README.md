[ ![Docker](https://img.shields.io/badge/Docker%20Image-309DEE?style=for-the-badge&logo=docker&logoColor=white) ](https://hub.docker.com/r/jack20191124/drill)
[ ![License Badge](https://img.shields.io/badge/Apache%202.0-F25910.svg?style=for-the-badge&logo=Apache&logoColor=white) ](https://www.apache.org/licenses/LICENSE-2.0)
[ ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/QubitPi/jupiter/MongoDB%20CI/mongodb?logo=github&style=for-the-badge) ](https://github.com/QubitPi/jupiter/actions/workflows/mongodb-ci.yml)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/QubitPi/jupiter/mongodb?logo=github&style=for-the-badge)

MongoDB Docker Image
====================

![MongoDB Logo](https://user-images.githubusercontent.com/16126939/180642857-ad01c264-686a-4b93-a26c-88427f1a7ed9.png)

This image is **designed for integration tests of Java-based MongoDB application**. The image allows application to test
against a real mongo instance in a simple pull-test-remove fashion:

* **step 1**: In integration test, have `MongoClientURL = "mongodb://localhost:27017"`
* **step 2**: Before integration tests, [pull image](#docker-hub)
* **step 3**: [Start container](#standup-a-container)
* **step 4**: Run integration test
* **step 5**: Stop and delete the container(and image)

_The container of this image also runs a
[pseudo-distributed Hadoop instance](https://hub.docker.com/r/jack20191124/hadoop) inside, this means you could also 
execute test logic involving HDFS._

**This image must not be used in production because it accepts connections from all external IP's**

Get Image
---------

### Docker Hub

You can pull the image from [my docker hub](https://hub.docker.com/r/jack20191124/mongodb/):

    docker pull jack20191124/mongodb

### GitHub

You could also build the image from [my source repository](https://github.com/QubitPi/jupiter/tree/mongo/):

    git clone https://github.com/QubitPi/jupiter.git
    cd jupiter
    git checkout mongodb
    docker build -t jack20191124/mongodb .

Standup a Container
-------------------

Once image is on your machine(either by pulling or building), you can have a MongoDB instance in seconds by runnig

    docker run --name=mongodb -it -p 27017:27017 jack20191124/mongodb /etc/init.sh -bash
    
* 27017 is the default port for connecting to MongoDB

Mongo Java API
--------------

This image comes with an [example app](./MongoClient) that connects to mongo, writes some data to it, and reads the data 
from it, which demonstrate how applications could run tests against container:

    cd MongoClient
    
Compile this app:

    mvn clean package
    
By running this app, we will create a database called `human`, a collection called `people`, and insert a document into
the collection. To run the app:

    java -jar target/MongoClient-1.0-SNAPSHOT.jar
    
You will see the console output something like

    { "_id" : "jack" , "name" : "Jiaqi" , "address" : { "street" : "123 Fake St" , "city" : "Faketon"} , "books" : [ 123 , 456]}
   
This is the data we just saved. Next, go to container console and log into mongo shell:

    mongo
    
You will see the data that our app created:

    > show dbs
    human  0.000GB
    admin  0.000GB
    local  0.000GB
    
    > use human
    
    > db.people.find()
    { "_id" : ObjectId("..."), "id" : "jack", "name" : "Jack", "address" : { "street" : "123 Fake St", "city" : "Faketon" }, "books" : [ 123, 456 ] }

License
-------

The use and distribution terms for this software are covered by the Apache License, Version 2.0
( http://www.apache.org/licenses/LICENSE-2.0.html ).
