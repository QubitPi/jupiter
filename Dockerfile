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

FROM jack20191124/hadoop

LABEL maintainer="Jiaqi (Jack) Liu"
LABEL maintainer-email="jiaqixy@protonmail.com"

ARG DRUID_VERSION=0.15.0
ARG ZK_VERSION=3.4.11

ENV DRUID_HOME /druid
ENV ZK_HOME /zookeeper

# Ubuntu updates
RUN apt-get update
RUN apt-get upgrade -y
RUN apt update
RUN apt upgrade -y

# Druid quick-start dependencies
RUN apt-get install perl -y
RUN apt-get install curl -y

# Install Druid
RUN wget https://archive.apache.org/dist/incubator/druid/$DRUID_VERSION-incubating/apache-druid-$DRUID_VERSION-incubating-bin.tar.gz
RUN tar -xzvf apache-druid-$DRUID_VERSION-incubating-bin.tar.gz
RUN rm apache-druid-$DRUID_VERSION-incubating-bin.tar.gz
RUN mv apache-druid-$DRUID_VERSION-incubating druid

# Install ZooKeeper
# Druid has a dependency on Apache ZooKeeper for distributed coordination.
# The Druid quick-startup scripts for the tutorial will expect the contents of the Zookeeper tarball to be located at zk under the apache-druid-0.15.0-incubating package root.
RUN curl https://archive.apache.org/dist/zookeeper/zookeeper-$ZK_VERSION/zookeeper-$ZK_VERSION.tar.gz -o zookeeper-$ZK_VERSION.tar.gz
RUN tar -xzvf zookeeper-$ZK_VERSION.tar.gz
RUN rm zookeeper-$ZK_VERSION.tar.gz
RUN mv zookeeper-$ZK_VERSION zk
RUN mv zk $DRUID_HOME

# Add init file for container
ADD druid-init.sh /etc/druid-init.sh
RUN chown root:root /etc/druid-init.sh
RUN chmod 700 /etc/druid-init.sh
ENV INIT /etc/druid-init.sh
