#!/bin/bash

domain=$1

echo $domain

if [ -z "$domain" ]; then
    echo "Vocë deve adicionar o argumento do dominio"
	exit;
fi

key_pass=secret

mkdir certs

sudo openssl pkcs12 -export -in /etc/letsencrypt/live/$domain/cert.pem -inkey /etc/letsencrypt/live/$domain/privkey.pem -certfile /etc/letsencrypt/live/$domain/chain.pem -out certs/key.p12 -name keystore
sudo keytool -import -alias e-laudos.com \
	-keystore certs/cacerts \
	-file /etc/letsencrypt/live/$domain/cert.pem \
	-storepass changeit \
	-noprompt

#sudo $JAVA_HOME/bin/keytool -importkeystore -deststorepass $key_pass -destkeypass $key_pass -destkeystore certs/keystore.jks -srckeystore certs/keystore.p12 -srcstoretype PKCS12 -srcstorepass $key_pass -alias cert

pushd data

sed -i 's;127.0.0.1;0.0.0.0;g' *

docker-compose restart
