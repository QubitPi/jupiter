#!/bin/bash

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

# run parent(HBase) init
sh /etc/hbase-init.sh

# Start ZooKeeper
cd $ZK_HOME
cd conf
cp zoo_sample.cfg zoo.cfg

$ZK_HOME/bin/zkServer.sh start &
wait

# Start Dill
cd $DRILL_HOME
bin/drillbit.sh start

if [[ $1 == "-d" ]]; then
    # just keep container running by hanging the shell
    while true; do sleep 1000 ; done
fi

if [[ $1 == "-bash" ]]; then
    # enter container's interactive shell
    /bin/bash
fi