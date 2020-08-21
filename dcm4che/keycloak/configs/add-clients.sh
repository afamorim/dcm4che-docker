#!/bin/bash

echo "Set host $ARCHIVE_HOST to clients OIDC" |& tee -a $JBOSS_HOME/configs/log.log
cp $JBOSS_HOME/configs/templates/* $JBOSS_HOME/configs/
sed -i -e "s;%HOST%;$ARCHIVE_HOST;g" "$JBOSS_HOME/configs/dcm4chee-arc-ui.json"
sed -i -e "s;%HOST%;$ARCHIVE_HOST;g" "$JBOSS_HOME/configs/wildfly-console.json"

echo "Waiting for $ARCHIVE_HOST:8880 ..." |& tee -a $JBOSS_HOME/configs/log.log
while ! nc -w 1 -z $ARCHIVE_HOST 8880; do sleep 1; done
echo "Done" |& tee -a $JBOSS_HOME/configs/log.log

$JBOSS_HOME/bin/kcadm.sh config credentials --server http://$ARCHIVE_HOST:8880/auth --realm dcm4che --user admin --password admin --client admin-cli |& tee -a $JBOSS_HOME/configs/log.log
$JBOSS_HOME/bin/kcadm.sh create clients --realm dcm4che -f $JBOSS_HOME/configs/dcm4chee-arc-ui.json |& tee -a $JBOSS_HOME/configs/log.log
$JBOSS_HOME/bin/kcadm.sh create clients --realm dcm4che -f $JBOSS_HOME/configs/wildfly-console.json |& tee -a $JBOSS_HOME/configs/log.log
$JBOSS_HOME/bin/kcadm.sh create clients --realm dcm4che -f $JBOSS_HOME/configs/curl.json |& tee -a $JBOSS_HOME/configs/log.log

echo "Finished clients creation" |& tee -a $JBOSS_HOME/configs/log.log