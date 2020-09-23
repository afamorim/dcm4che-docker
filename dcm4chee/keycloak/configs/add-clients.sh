#!/bin/bash

echo "Set host $ARCHIVE_HOST to clients OIDC"
cp $JBOSS_HOME/configs/templates/* $JBOSS_HOME/configs/
sed -i -e "s;%HOST%;$ARCHIVE_HOST;g" "$JBOSS_HOME/configs/dcm4chee-arc-ui.json"
sed -i -e "s;%HOST%;$ARCHIVE_HOST;g" "$JBOSS_HOME/configs/wildfly-console.json"

credentials_log="$JBOSS_HOME/standalone/log/credentials.log"

touch $credentials_log

$JBOSS_HOME/bin/kcadm.sh config credentials --server $AUTH_SERVER_URL --realm dcm4che --user admin --password admin --client admin-cli |& tee $credentials_log

echo "Waiting for credentials..."
while [[ $(cat $credentials_log) == *"Failed"* ]]; do 
    $JBOSS_HOME/bin/kcadm.sh config credentials --server $AUTH_SERVER_URL --realm dcm4che --user admin --password admin --client admin-cli |& tee $credentials_log
done
echo "Done credentials"

$JBOSS_HOME/bin/kcadm.sh create clients --realm dcm4che -f $JBOSS_HOME/configs/dcm4chee-arc-ui.json |& tee -a $credentials_log
$JBOSS_HOME/bin/kcadm.sh create clients --realm dcm4che -f $JBOSS_HOME/configs/wildfly-console.json |& tee -a $credentials_log
$JBOSS_HOME/bin/kcadm.sh create clients --realm dcm4che -f $JBOSS_HOME/configs/curl.json |& tee -a $credentials_log

echo "Finished clients creation"