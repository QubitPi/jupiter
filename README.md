[ ![Docker](https://img.shields.io/badge/Docker%20Image-309DEE?style=for-the-badge&logo=docker&logoColor=white) ](https://hub.docker.com/r/jack20191124/apachepig)
[ ![License Badge](https://img.shields.io/badge/Apache%202.0-F25910.svg?style=for-the-badge&logo=Apache&logoColor=white) ](https://www.apache.org/licenses/LICENSE-2.0)
[ ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/QubitPi/jupiter/Apache%20Pig%20CI/apachepig?logo=github&style=for-the-badge) ](https://github.com/QubitPi/jupiter/actions/workflows/apachepig-ci.yml)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/QubitPi/jupiter/apachepig?logo=github&style=for-the-badge)

Docker Image for Apache Pig on Hadoop
=====================================

![apache-logo](https://user-images.githubusercontent.com/16126939/176544349-0cb18331-158a-4d27-88c2-b47a6326ab0c.png)

This image includes the following features:

* Quickly standup a Apache Pig(damn it!) instance on top of a real Hadoop Distributed File System (HDFS).
* Users can interact with Apache Pig on the HDFS that mimics a production MapReduce workflow.
* The container of this image also runs on top of a HBase instance in pseudo-distributed mode
* Users could use the container to inject data into HBase through Apache Pig scripts

Get Image
---------

### Docker Hub

You can pull the image from [my docker hub](https://hub.docker.com/r/jack20191124/apachepig/):

    docker pull jack20191124/apachepig

### GitHub

You could also build the image from [my source repository](https://github.com/QubitPi/jupiter/tree/apachepig/):

    git clone https://github.com/QubitPi/jupiter.git
    cd jupiter
    git checkout apachepig
    docker build -t jack20191124/apachepig .

Standup a Container
-------------------

Once image is on your machine(either by pulling or building), you can have Apache Pig on Mapreduce Execution Mode in 
seconds:

    docker run --name=apachepig -it jack20191124/apachepig /etc/apache-pig-init.sh

The container will spin up a HDFS in the container and takes you into its shell in the end

Run Apache Pig Tutorial Inside Container
----------------------------------------

Other than preparing a running HDFS and HBase for you on startup, the container also automatically prepares environment 
for you so that you can quickly run a Pig tutorial example:

    cd ../tutorial/pigtmp/
    pig script1-hadoop.pig

The last command runs the Pig scripts in MapReduce mode. After MapReduce job finishes, you can review the result files:

    hdfs dfs -cat /user/root/script1-hadoop-results/*
    
Running Apache Pig Command
--------------------------

You can run Pig in interactive mode using the Grunt shell. Invoke the Grunt shell using the "pig" command (as shown below) 
and then enter your Pig Latin statements and Pig commands interactively at the command line.

### Example

These Pig Latin statements extract all user IDs from the `/etc/passwd` file.

First, copy the `/etc/passwd` file to your local working directory.

    cd home/
    cp /etc/passwd .

Next, invoke the Grunt shell by typing the "pig" command (in local mode).

    pig -x local

Then, enter the Pig Latin statements interactively at the grunt prompt (be sure to include the semicolon after each 
statement). The DUMP operator will display the results to your terminal screen.

    grunt> A = load 'passwd' using PigStorage(':');
    grunt> B = LIMIT A 1;
    grunt> DUMP B;

Apache Pig with HBase
---------------------

### Simple Grunt Example

In this example, we simply going to use the HBase shell to create a table and then load the data, manipulate, and dump
the data in Grunt.

From the HBase shell, create the `tourist` table with the column family info:

    $HBASE_HOME/bin/hbase shell
    
    create "tourist", "hotel", "scenic area", "transportation"

Create a row with the `hotel` column family and the column keys `name` and `rating`:

    put "tourist", "row1", "hotel:name", "name1"
    put "tourist", "row1", "hotel:rating", "5"

You can verify that the row has been inserted into the table:

    hbase(main):001:0> scan "tourist"
    ROW                                 COLUMN+CELL                                                                                            
     row1                               column=hotel:name, timestamp=1532568254759, value=name1                                                
     row1                               column=hotel:rating, timestamp=1532568260126, value=5 

Close your HBase shell and open up Grunt(`pig`).

Load the data from the `tourist` table and display the data with the following commands:

    tourist = LOAD 'hbase://tourist'
    USING org.apache.pig.backend.hadoop.hbase.HBaseStorage('hotel:name hotel:rating', '-loadKey true')
    AS (id:bytearray, name:chararray, rating:chararray);

    describe tourist
    dump tourist

You should see a lot of logs from the map-reduce jobs, the inputs, outputs, counters, and finally the tuples containing 
your data as shown below:

    (row1,name1,5)
    
### Load Avro into HBase

In this example, we will have Apache Pig load a Avro file and write it to the HBase table we created above using a
script.

    cd $PIG_HOME/lib
    pig script.pig
    
Now if you go to HBase shell and scan the same `tourist` table, you will see new data have been added by the script

    hbase(main):001:0> scan "tourist"
    ROW                                 COLUMN+CELL                                                                                            
     row1                               column=hotel:name, timestamp=1532568254759, value=name1                                                
     row1                               column=hotel:rating, timestamp=1532568260126, value=5                                                  
     row2                               column=hotel:name, timestamp=1532568270939, value=name2                                                
     row2                               column=hotel:rating, timestamp=1532568270939, value=5                                                  
     row3                               column=hotel:name, timestamp=1532568270952, value=name3                                                
     row3                               column=hotel:rating, timestamp=1532568270952, value=4  

License
-------

The use and distribution terms for this software are covered by the Apache License, Version 2.0
( http://www.apache.org/licenses/LICENSE-2.0.html ).
