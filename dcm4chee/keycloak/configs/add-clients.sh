#!/bin/bash

echo "Set host $ARCHIVE_HOST to clients OIDC"
cp $JBOSS_HOME/configs/templates/* $JBOSS_HOME/configs/
sed -i -e "s;%HOST%;$ARCHIVE_HOST;g" "$JBOSS_HOME/configs/dcm4chee-arc-ui.json"
sed -i -e "s;%HOST%;$ARCHIVE_HOST;g" "$JBOSS_HOME/configs/wildfly-console.json"

log_dir="$JBOSS_HOME/standalone/log"

mkdir -p $log_dir
log_credentials="$log_dir/credentials.log"
touch $log_credentials

echo "Waiting for avaliable $ARCHIVE_HOST:8880 ..."
while ! nc -w 1 -z $ARCHIVE_HOST 8880; do sleep 1; done
echo "Done avaliable"

credential_url="http://$ARCHIVE_HOST:8880/auth"

echo "Waiting for credentials in $credential_url..."
$JBOSS_HOME/bin/kcadm.sh config credentials --server $credential_url --realm dcm4che --user admin --password admin --client admin-cli |& tee $log_credentials

while [[ $(cat $log_credentials) == *"Failed"* || $(cat $log_credentials) == *"No server specified"* ]]; do 
    echo "Waiting for credentials in $credential_url..."
    $JBOSS_HOME/bin/kcadm.sh config credentials --server $credential_url --realm dcm4che --user admin --password admin --client admin-cli |& tee $log_credentials
done
echo "Done credentials"

$JBOSS_HOME/bin/kcadm.sh create clients --realm dcm4che -f $JBOSS_HOME/configs/dcm4chee-arc-ui.json |& tee -a $log_credentials
$JBOSS_HOME/bin/kcadm.sh create clients --realm dcm4che -f $JBOSS_HOME/configs/wildfly-console.json |& tee -a $log_credentials
$JBOSS_HOME/bin/kcadm.sh create clients --realm dcm4che -f $JBOSS_HOME/configs/curl.json |& tee -a $log_credentials

echo "Finished clients creation"
