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

# Set the env variable DEBIAN_FRONTEND to noninteractive to get apt-get working without getting interactive input.
ENV DEBIAN_FRONTEND noninteractive

# Setup dependencies
RUN apt-get update
RUN apt-get upgrade -y
RUN apt update
RUN apt upgrade -y
# run "make"
RUN apt-get install build-essential -y
# download Redis
RUN apt-get install wget -y
# run "make test"
RUN apt-get install -y tcl

# Install Redis
RUN wget http://download.redis.io/releases/redis-4.0.9.tar.gz
RUN tar -xzvf redis-4.0.9.tar.gz
RUN cd redis-4.0.9 && make && make install

# Start script
ADD init.sh /etc/init.sh
RUN chown root:root /etc/init.sh
RUN chmod 700 /etc/init.sh
ENV INIT /etc/init.sh
