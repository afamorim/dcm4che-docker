#!/bin/bash

domain=$1

echo $domain

if [ -z "$domain" ]; then
    echo "Vocë deve adicionar o argumento do dominio"
	exit;
fi

cert_path=certs

mkdir -p $cert_path

sudo rm $cert_path/cacerts.p12
sudo rm $cert_path/key.p12
sudo openssl pkcs12 -export -in /etc/letsencrypt/live/$domain/cert.pem -inkey /etc/letsencrypt/live/$domain/privkey.pem -certfile /etc/letsencrypt/live/$domain/chain.pem -out $cert_path/key.p12 -name keystore
sudo cp $cert_path/cacerts-main.p12 $cert_path/cacerts.p12
sudo keytool -import -alias e-laudos.com \
	-keystore $cert_path/cacerts.p12 \
	-file /etc/letsencrypt/live/$domain/cert.pem \
	-storepass secret \
	-noprompt

sudo chmod -R 777 $cert_path