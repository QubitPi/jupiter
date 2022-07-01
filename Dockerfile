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

# Some Chef features is not supported in latest Ubuntu
FROM ubuntu:14.04

LABEL maintainer="Jiaqi (Jack) Liu"
LABEL maintainer-email="jiaqixy@protonmail.com"

#################################################### Ubuntu updates ####################################################

RUN apt-get update
RUN apt-get upgrade -y
RUN apt update
RUN apt upgrade -y

############################################## Install auxiliary packages ##############################################

RUN apt-get install curl -y
RUN apt-get install emacs -y
RUN apt-get install tree -y

################################################### Install Chef DK ####################################################

RUN curl https://omnitruck.chef.io/install.sh | bash -s -- -P chefdk -c stable -v 2.5.3
