FROM vulcanos/nexus3

USER root

COPY start.sh ${NEXUS_HOME}/bin

RUN chown -R nexus:nexus ${NEXUS_HOME} \
    && export $(cat ${NEXUS_HOME}/bin/.env | xargs) \
    && sed '/^application-port/s:$:\napplication-port-ssl=8443:' -i ${NEXUS_HOME}/etc/nexus-default.properties \
    && sed '/^nexus-args/s:$:,${jetty.etc}/jetty-https.xml:' -i ${NEXUS_HOME}/etc/nexus-default.properties \
    && rm -rf ${NEXUS_HOME}/etc/ssl \
    && ln -s ${NEXUS_DATA}/etc/ssl ${NEXUS_HOME}/etc/ssl


USER nexus

EXPOSE 8443

CMD ["sh", "/opt/nexus/bin/start.sh"]