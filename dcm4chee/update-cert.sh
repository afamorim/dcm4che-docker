#!/bin/bash

domain=$1

pushd /home/elaudoss/dcm4che-docker/dcm4chee/

days_to_expiry=$(certbot certificates | grep -P '\d+ day' -o | sed "s/ day//")
if [ $days_to_expiry -gt 10 ]; then
    echo "Certificado digital continua válido";
    exit;
fi
certbot renew
cp /etc/letsencrypt/live/$domain/privkey.pem /etc/webmin/letsencrypt-key.pem
cp /etc/letsencrypt/live/$domain/fullchain.pem /etc/webmin/letsencrypt-cert.pem
bash cert-install.sh $domain
docker-compose -p dcm4chee restart
