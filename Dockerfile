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

FROM ubuntu:18.04

LABEL maintainer="Jiaqi (Jack) Liu"
LABEL maintainer-email="jiaqixy@protonmail.com"

ENV FABAN_HOME=/faban

# Ubuntu updates
RUN apt-get update
RUN apt-get upgrade -y
RUN apt update
RUN apt upgrade -y

# Java - a jdk is required(bin/jar must exists under JAVA_HOME). looks like Oracle banned Java 8 CMD install. this is
# workaround
RUN apt-get install default-jdk -y
ENV JAVA_HOME /usr/lib/jvm/java-1.11.0-openjdk-amd64

# Auxiliary packages
RUN apt-get install wget -y

# Installing Faban
RUN wget http://faban.org/downloads/faban-kit-latest.tar.gz
RUN tar -xzvf faban-kit-latest.tar.gz
RUN rm faban-kit-latest.tar.gz

# install container start script
ADD init.sh /etc/init.sh
RUN chown root:root /etc/init.sh
RUN chmod 700 /etc/init.sh
ENV INIT /etc/init.sh
