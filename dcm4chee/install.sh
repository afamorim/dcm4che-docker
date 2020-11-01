#!/bin/bash

bash cert-install.sh
docker-compose -p dcm4chee up -d --build
