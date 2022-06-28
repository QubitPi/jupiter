# Copyright Jiaqi (Jack)
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

##################################### Install Setup #####################################

# Ubuntu updates
RUN apt-get update
RUN apt-get upgrade -y
RUN apt update
RUN apt upgrade -y
RUN apt-get install build-essential -y

RUN apt-get install wget -y

# Java & Maven
RUN apt-get install openjdk-8-jdk -y
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre/
RUN apt-get install maven -y

##################################### Install MongoDB #####################################

# Import the public key used by the package management system.
RUN wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | apt-key add -

# Create a list file for MongoDB.
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-5.0.list

# Reload local package database
RUN apt-get update

# Avoid interactive mongo install
ARG DEBIAN_FRONTEND=noninteractive

# Install mongo
RUN apt-get install mongodb-org -y
RUN apt install mongodb-server -y

##################################### Prepare Runtime MongoDB #####################################

# Fix error while starting MongoDB: mongod --bind_ip_all &
# exception in initAndListen: NonExistentPath: Data directory /data/db not found., terminating
RUN mkdir -p /data/db

# Add script for starting Mongo DB
ADD init.sh /etc/init.sh
RUN chown root:root /etc/init.sh
RUN chmod 700 /etc/init.sh
ENV INIT /etc/init.sh
