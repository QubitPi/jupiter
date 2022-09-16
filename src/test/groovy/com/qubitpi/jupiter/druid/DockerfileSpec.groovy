/*
 * Copyright Jiaqi Liu
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.qubitpi.jupiter.druid

import org.testcontainers.containers.GenericContainer

import spock.lang.Specification

class DockerfileSpec extends Specification {

    def "Druid console is accessible"() {
        setup:
        GenericContainer container = new GenericContainer("jack20191124/druid")
                .withExposedPorts(8090, 8081, 8888)
                .withCommand("sh /etc/init.sh")
                .withCommand("cd \$DRUID_HOME && bin/start-micro-quickstart &")
                .withCommand("while true; do sleep 1000 ; done")

        container.start()

        cleanup:
        container.close()
    }
}
