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

FROM jack20191124/hbase

LABEL maintainer="Jiaqi (Jack)"
LABEL maintainer-email="jiaqixy@protonmail.com"

ARG DRILL_VERSION=1.13.0
ARG ZK_VERSION=3.4.12

# Auxiliary packages
RUN apt-get install lsb-release -y
RUN apt-get install sudo -y

# Download ZooKeeper
RUN wget https://archive.apache.org/dist/zookeeper/zookeeper-$ZK_VERSION/zookeeper-$ZK_VERSION.tar.gz
RUN tar -xvzf zookeeper-$ZK_VERSION.tar.gz
RUN rm zookeeper-$ZK_VERSION.tar.gz
RUN mv zookeeper-$ZK_VERSION zk

# Download Drill
RUN wget https://archive.apache.org/dist/drill/drill-$DRILL_VERSION/apache-drill-$DRILL_VERSION.tar.gz
RUN tar -xvzf apache-drill-$DRILL_VERSION.tar.gz
RUN rm apache-drill-$DRILL_VERSION.tar.gz
RUN mv apache-drill-$DRILL_VERSION drill

# Configure Drill env variables
ENV DRILL_HOME /drill
ENV ZK_HOME /zk

ADD drill-init.sh /etc/drill-init.sh
RUN chown root:root /etc/drill-init.sh
RUN chmod 700 /etc/drill-init.sh
ENV INIT /etc/drill-init.sh
