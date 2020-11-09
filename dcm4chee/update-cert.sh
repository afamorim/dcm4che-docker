#!/bin/bash

domain=$1

certbot renew
cp /etc/letsencrypt/live/$domain/privkey.pem /etc/webmin/letsencrypt-key.pem
cp /etc/letsencrypt/live/$domain/cert.pem /etc/webmin/letsencrypt-cert.pem
bash cert-install.sh $domain
docker-compose -p dcm4chee restart
