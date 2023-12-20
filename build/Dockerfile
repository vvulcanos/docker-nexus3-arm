# Copyright (c) 2016-present Sonatype, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


FROM alpine:3

ARG VERSION="3.63.0-01"

ENV VERSION $VERSION

LABEL name="Nexus Repository Manager" \
    maintainer="Sonatype <support@sonatype.com>" \
    vendor="Sonatype" \
    version="3.63.0-01" \
    release="3.63.0" \
    url="https://sonatype.com" \
    summary="The Nexus Repository Manager server with universal support for popular component formats." \
    description="The Nexus Repository Manager server with universal support for popular component formats." \
    run="docker run -d --name NAME -p 8081:8081 IMAGE" \
    stop="docker stop NAME"  \
    com.sonatype.license="Apache License, Version 2.0" \
    com.sonatype.name="Nexus Repository Manager base image" \
    io.k8s.description="The Nexus Repository Manager server with universal support for popular component formats." \
    io.k8s.display-name="Nexus Repository Manager" \
    io.openshift.expose-services="8081:8081" \
    io.openshift.tags="Sonatype,Nexus,Repository Manager"

# configure nexus runtime
ENV SONATYPE_DIR="/opt/"
ENV NEXUS_HOME="/opt/nexus" \
    NEXUS_DATA="/nexus-data" \
    NEXUS_CONTEXT='' \
    SONATYPE_WORK="/opt/sonatype/sonatype-work" \
    DOCKER_TYPE="alpine-docker"

# install nexus3 for unix & java
# COPY --chown=root:root entrypoint.sh ./
# RUN sh ./entrypoint.sh

RUN wget https://download.sonatype.com/nexus/3/nexus-${VERSION}-unix.tar.gz \
    && tar -zxvf nexus-${VERSION}-unix.tar.gz \
    && rm nexus-${VERSION}-unix.tar.gz \
    && mv nexus-${VERSION} ${NEXUS_HOME} \
    && mv sonatype-work/nexus3 ${NEXUS_DATA} \
    && adduser -D -h ${NEXUS_HOME}/bin nexus \
    && chown -R nexus:nexus ${NEXUS_HOME} \
    && chown -R nexus:nexus ${NEXUS_DATA} \
    && sed -i 's/..\/sonatype-work\/nexus3/\/nexus-data/g' ${NEXUS_HOME}/bin/nexus.vmoptions \
    && sed -i 's/\#run_as_user=\"\"/run_as_user=\"nexus\"/g' ${NEXUS_HOME}/bin/nexus.rc \
    && chmod u+s ${NEXUS_HOME}/bin/nexus \
    && apk add openjdk8 \
    && apk cache clean

EXPOSE 8081


ENV INSTALL4J_ADD_VM_PARAMS="-Xms2703m -Xmx2703m -XX:MaxDirectMemorySize=2703m -Djava.util.prefs.userRoot=${NEXUS_DATA}/javaprefs"

USER nexus
WORKDIR ${NEXUS_HOME}
VOLUME ${NEXUS_DATA}

CMD ["/opt/nexus/bin/nexus", "run"]
