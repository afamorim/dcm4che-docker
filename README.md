# dcm4chee-docker

1. Create and start the 4 containers by invoking:

```bash
docker-compose -p dcm4chee up -d
```

2. Register the Archive UI as OIDC client in Keycloak as described [above](https://github.com/dcm4che/dcm4chee-arc-light/wiki/Run-secured-archive-services-on-a-single-host#register-the-archive-ui-as-oidc-client-in-keycloak).

3. Register the WildFly Administration Console as OIDC client in Keycloak as described [above](https://github.com/dcm4che/dcm4chee-arc-light/wiki/Run-secured-archive-services-on-a-single-host#register-the-wildfly-administration-console-as-oidc-client-in-keycloak).
