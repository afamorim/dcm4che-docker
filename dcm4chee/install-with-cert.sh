#!/bin/bash

domain=$1

bash cert-install.sh $domain
docker-compose -p dcm4chee up -d --build
