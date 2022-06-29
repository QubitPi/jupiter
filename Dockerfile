# Copyright Jiaqi Liu
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM ubuntu:latest

LABEL maintainer="Jiaqi (Jack) Liu"
LABEL maintainer-email="jiaqixy@protonmail.com"

ARG ZOOKEEPER_VERSION=3.4.13

# Ubuntu updates
RUN apt-get update
RUN apt-get upgrade -y
RUN apt update
RUN apt upgrade -y

# Java
RUN apt-get install openjdk-8-jdk -y
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre/

# Auxiliary packages
RUN apt-get install -y wget

# Download ZooKeeper
RUN wget https://archive.apache.org/dist/zookeeper/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz
RUN tar -xvzf zookeeper-$ZOOKEEPER_VERSION.tar.gz
RUN rm zookeeper-$ZOOKEEPER_VERSION.tar.gz

# Rename "zookeeper-<version>" to "zookeeper" as ZOOKEEPER_HOME
RUN mv zookeeper-$ZOOKEEPER_VERSION zookeeper

# Configure ZooKeeper env variables
ENV ZOOKEEPER_HOME /zookeeper

# Configure ZooKeeper
RUN mv $ZOOKEEPER_HOME/conf/zoo_sample.cfg $ZOOKEEPER_HOME/conf/zoo.cfg

# Add script for starting HDFS
ADD init.sh /etc/init.sh
RUN chown root:root /etc/init.sh
RUN chmod 700 /etc/init.sh
ENV INIT /etc/init.sh
