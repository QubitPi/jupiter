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

LABEL maintainer="Jiaqi (Jack) Liu"
LABEL maintainer-email="jiaqixy@protonmail.com"

# Install OpenTSDB
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y autoconf

# The latest Ubuntu install Python3 by default. This links python executable to python3 so that OpenTSDB
# property with python
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gnuplot
RUN git clone https://github.com/OpenTSDB/opentsdb.git && cd opentsdb && ./build.sh

# Define env variables
ENV OPENTSDB_HOME /opentsdb
ENV OPENTSDB_PORT 4242
ENV STATIC_ROOT $OPENTSDB_HOME/build/staticroot
ENV CACHE_DIR $OPENTSDB_HOME/cachedir
RUN mkdir $OPENTSDB_HOME/cachedir

# Add init file for container
ADD opentsdb-init.sh /etc/opentsdb-init.sh
RUN chown root:root /etc/opentsdb-init.sh
RUN chmod 700 /etc/opentsdb-init.sh
ENV INIT /etc/opentsdb-init.sh
