FROM dcm4che/keycloak:11.0.2

COPY configs/ $JBOSS_HOME/configs/

RUN chmod -R 777 $JBOSS_HOME/configs/

RUN sed -i -e 's;exec "$@";;g' "/docker-entrypoint.sh" && \
echo "$JBOSS_HOME/configs/add-clients.sh &" >> /docker-entrypoint.sh && \
echo 'exec "$@"' >> /docker-entrypoint.sh