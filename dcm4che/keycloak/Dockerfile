FROM dcm4che/keycloak:10.0.2

COPY configs/ $JBOSS_HOME/configs/

RUN \
chmod -R +x /opt/keycloak/configs && \
sed -i -e "s;%HOST%;$ARCHIVE_HOST;g" "/opt/keycloak/configs/dcm4chee-arc-ui.json" && \
sed -i -e "s;%HOST%;$ARCHIVE_HOST;g" "/opt/keycloak/configs/wildfly-console.json"

RUN sed -i -e 's;exec "$@";;g' "/docker-entrypoint.sh" && \
echo "$JBOSS_HOME/configs/add-clients.sh &" >> /docker-entrypoint.sh && \
echo 'exec "$@"' >> /docker-entrypoint.sh