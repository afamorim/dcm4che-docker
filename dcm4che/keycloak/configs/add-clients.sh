#!/bin/bash

echo "Waiting for port 8880..."
while ! nc -w 1 -z $ARCHIVE_HOST 8880; do sleep 1; done
echo "done"

/opt/keycloak/bin/kcadm.sh config credentials --server http://$ARCHIVE_HOST:8880/auth --realm dcm4che --user admin --password admin --client admin-cli && \
/opt/keycloak/bin/kcadm.sh create clients --realm dcm4che -f /opt/keycloak/configs/dcm4chee-arc-ui.json && \
/opt/keycloak/bin/kcadm.sh create clients --realm dcm4che -f /opt/keycloak/configs/wildfly-console.json