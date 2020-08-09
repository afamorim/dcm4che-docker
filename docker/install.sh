
# create docker network
docker network create dcm4chee_default

# create ldap service
docker run --network=dcm4chee_default --name ldap \
           -p 389:389 \
           -v $(pwd)/data/ldap:/var/lib/openldap/openldap-data \
           -v $(pwd)/data/slapd.d:/etc/openldap/slapd.d \
           -e STORAGE_DIR=/storage/fs1 \
           -d dcm4che/slapd-dcm4chee:2.4.50-22.3

# create db service
docker run --network=dcm4chee_default --name db \
           -p 5432:5432 \
           -e POSTGRES_DB=pacsdb \
           -e POSTGRES_USER=pacs \
           -e POSTGRES_PASSWORD=pacs \
           -v /etc/localtime:/etc/localtime:ro \
           -v /etc/timezone:/etc/timezone:ro \
           -v $(pwd)/data/db:/var/lib/postgresql/data \
           -d dcm4che/postgres-dcm4chee:12.2-22

# create pacs service
docker run --network=dcm4chee_default --name arc \
           -p 8080:8080 \
           -p 8443:8443 \
           -p 9990:9990 \
           -p 9993:9993 \
           -p 11112:11112 \
           -p 2762:2762 \
           -p 2575:2575 \
           -p 12575:12575 \
           -e POSTGRES_DB=pacsdb \
           -e POSTGRES_USER=pacs \
           -e POSTGRES_PASSWORD=pacs \
           -e WILDFLY_WAIT_FOR="ldap:389 db:5432" \
           -e WILDFLY_CHOWN="/opt/wildfly/standalone /storage" \
           -v /etc/localtime:/etc/localtime:ro \
           -v /etc/timezone:/etc/timezone:ro \
           -v $(pwd)/data/wildfly:/opt/wildfly/standalone \
           -v $(pwd)/data/storage:/storage \
           -d dcm4che/dcm4chee-arc-psql:5.22.3
