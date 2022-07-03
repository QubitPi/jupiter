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

ARG NGINX_VERSION=1.16.1

# Ubuntu updates
RUN apt-get update
RUN apt-get upgrade -y
RUN apt update
RUN apt upgrade -y

# Auxiliary packages
RUN apt-get install wget -y
RUN apt-get install emacs -y
RUN apt-get install build-essential -y
RUN apt-get install libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev -y

# access.log visualization at runtime
RUN apt-get install goaccess -y

# Support SSL
# ARG DEBIAN_FRONTEND=noninteractive
# RUN apt-get install python-certbot-nginx -y

# Download Nginx
RUN wget https://nginx.org/download/nginx-$NGINX_VERSION.tar.gz
RUN tar -xvzf nginx-$NGINX_VERSION.tar.gz
RUN rm nginx-$NGINX_VERSION.tar.gz

# Rename "nginx-<version>" to "nginx"
RUN mv nginx-$NGINX_VERSION nginx

# Install Nginx
# ./configure to install as Ubuntu executable in order to support command auto-completion "nginx"
RUN cd nginx && ./configure --sbin-path=/bin/nginx && make && make install

# Add script for starting nginx
ADD init.sh /etc/init.sh
RUN chown root:root /etc/init.sh
RUN chmod 700 /etc/init.sh
ENV INIT /etc/init.sh
