#!/bin/bash

domain=$1

echo $domain

if [ -z "$domain" ]; then
    echo "Vocë deve adicionar o argumento do dominio"
	exit;
fi

key_pass=keypwd

sudo openssl pkcs12 -export -in /etc/letsencrypt/live/$domain/fullchain.pem -inkey /etc/letsencrypt/live/$domain/privkey.pem -out certs/keystore.p12 -name keystore
sudo $JAVA_HOME/bin/keytool -importkeystore -deststorepass $key_pass -destkeypass $key_pass -destkeystore certs/keystore.jks -srckeystore certs/keystore.p12 -srcstoretype PKCS12 -srcstorepass $key_pass -alias cert

pushd data

sed -i 's;127.0.0.1;0.0.0.0;g' *
