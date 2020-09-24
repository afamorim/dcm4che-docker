#!/bin/bash

domain=$1

echo $domain

sudo openssl pkcs12 -export -out data/keycloak/configuration/keystores/key.p12 -inkey /etc/letsencrypt/live/$domain/privkey.pem -in /etc/letsencrypt/live/$domain/cert.pem -certfile /etc/letsencrypt/live/$domain/chain.pem