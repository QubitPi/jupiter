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
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HttpWaitStrategy
import org.testcontainers.containers.wait.strategy.WaitAllStrategy
import org.testcontainers.containers.wait.strategy.WaitStrategy

import spock.lang.Specification

import java.time.Duration

class DockerfileSpec extends Specification {

    def "Druid console is accessible"() {
        setup:
        GenericContainer container = new GenericContainer("jack20191124/druid")
                .withExposedPorts(8090, 8081, 8888)
                .waitingFor(
                        new WaitAllStrategy()
                                .withStrategy(
                                        new HttpWaitStrategy()
                                                .forPort(8090)
                                                .withStartupTimeout(Duration.ofMinutes(1))
                                )
                                .withStrategy(
                                        new HttpWaitStrategy()
                                                .forPort(8081)
                                                .withStartupTimeout(Duration.ofMinutes(1))
                                )
                                .withStrategy(
                                        new HttpWaitStrategy()
                                                .forPort(8888)
                                                .withStartupTimeout(Duration.ofMinutes(1))
                                )
                ) // https://stackoverflow.com/a/58221327/14312712

        container.start()

        cleanup:
        container.close()
    }
}
