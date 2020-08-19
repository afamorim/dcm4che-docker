#!/bin/bash

cp $JBOSS_HOME/configs/templates/* $JBOSS_HOME/configs/
sed -i -e "s;%HOST%;$ARCHIVE_HOST;g" "$JBOSS_HOME/configs/dcm4chee-arc-ui.json"
sed -i -e "s;%HOST%;$ARCHIVE_HOST;g" "$JBOSS_HOME/configs/wildfly-console.json"

echo "Waiting for port 8880..."
while ! nc -w 1 -z $ARCHIVE_HOST 8880; do sleep 1; done
echo "done"

$JBOSS_HOME/bin/kcadm.sh config credentials --server http://$ARCHIVE_HOST:8880/auth --realm dcm4che --user admin --password admin --client admin-cli && \
$JBOSS_HOME/bin/kcadm.sh create clients --realm dcm4che -f $JBOSS_HOME/configs/dcm4chee-arc-ui.json && \
$JBOSS_HOME/bin/kcadm.sh create clients --realm dcm4che -f $JBOSS_HOME/configs/wildfly-console.json