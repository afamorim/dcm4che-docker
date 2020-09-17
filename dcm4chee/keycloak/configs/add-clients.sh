#!/bin/bash

echo "Set host $ARCHIVE_HOST to clients OIDC"
cp $JBOSS_HOME/configs/templates/* $JBOSS_HOME/configs/
sed -i -e "s;%HOST%;$ARCHIVE_HOST;g" "$JBOSS_HOME/configs/dcm4chee-arc-ui.json"
sed -i -e "s;%HOST%;$ARCHIVE_HOST;g" "$JBOSS_HOME/configs/wildfly-console.json"


credentials_log="$JBOSS_HOME/configs/credentials.log"

$JBOSS_HOME/bin/kcadm.sh config credentials --server http://$ARCHIVE_HOST:8880/auth --realm dcm4che --user admin --password admin --client admin-cli |& tee $credentials_log

echo "Waiting for credentials..."
while [[ $(cat $credentials_log) == *"Failed"* ]]; do 
    $JBOSS_HOME/bin/kcadm.sh config credentials --server http://$ARCHIVE_HOST:8880/auth --realm dcm4che --user admin --password admin --client admin-cli |& tee $credentials_log
done
echo "Done credentials"

$JBOSS_HOME/bin/kcadm.sh create clients --realm dcm4che -f $JBOSS_HOME/configs/dcm4chee-arc-ui.json
$JBOSS_HOME/bin/kcadm.sh create clients --realm dcm4che -f $JBOSS_HOME/configs/wildfly-console.json
$JBOSS_HOME/bin/kcadm.sh create clients --realm dcm4che -f $JBOSS_HOME/configs/curl.json

echo "Finished clients creation"