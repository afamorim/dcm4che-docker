# Manual de instalação do dcm4che 5

Este manual ajuda qualquer usuário na criação de ambiente do dcm4che 5.

## Pré-requisitos

É necessário ter instalado os seguintes softwares:

- Docker (https://docs.docker.com/engine/install/)
- Docker Compose (https://docs.docker.com/compose/install/)

## Instalação

1. Adicione __keycloak__ no arquivo "hosts"(`C:\Windows\System32\Drivers\etc\hosts`):

```bash
127.0.0.1	keycloak
```

2. Altere o host __keycloak__ das linhas 2 e 3 do arquivo `dcm4chee/docker-compose.env` e __localhost__ da linha 12 do arquivo `dcm4chee/arc/configuration/dicom-dcm4chee-arc.properties` para o nome do host (somente para sistemas que serão acessados externamente).

> Caso deseje alterar o nome do PACS de DCM4CHEE para um nome personalizado, altere a linha 4 do arquivo `dcm4chee/docker-compose.env`  e 11 do arquivo `dcm4chee/arc/configuration/dicom-dcm4chee-arc.properties`

3. Execute o comando docker dentro da pasta `dcm4chee`:

```bash
docker-compose -p dcm4chee up -d --build
```

4. Libere acesso à API RESTful:
    1. Acesse a URL https://localhost:8843/auth/admin/dcm4che/console/#/realms/dcm4che/clients
    2. Edite o Client ID `curl`
    3. Acesse a aba `Service Account Rules` e adicione `urer` em `Assigned Rules`

Crie um serviço para iniciar o computador com o ambiente iniciado.

https://www.it-swarm.dev/pt/docker/como-executar-o-docker-compose-d-na-inicializacao-do-sistema/832512690/

## Desinstalação

1. Remova todos os ambientes do projeto

```bash
docker-compose -p dcm4chee down
```

2. Apague restícios do docker que não estão sendo utilizados:

```bash
docker system prune --all
```

---

## Configurações Extras

Esta etapa apresenta algumas opções de configuração

### Definer o AE_TITLE do dcm4che na instalação

Para definir o AE_TITLE do dcm4che, altere o valor __DCM4CHEE__ (linha 4) do arquivo `dcm4chee/docker-compose.env` para o nome do AE_TITLE desejado

### Liberar acesso do Weasis

Para liberar o acesso do Weasis, será necessário seguir o passo-a-passo detalhado no link abaixo:

[https://github.com/dcm4che/dcm4chee-arc-light/wiki/User-Role-Access-to-Viewer](https://github.com/dcm4che/dcm4chee-arc-light/wiki/User-Role-Access-to-Viewer)

---

## Informações gerais

O arquivo `dcm4chee/docker-compose.env` possui algumas informações importantes:

- As variáveis POSTGRES_DB, POSTGRES_USER e POSTGRES_PASSWORD são respectivamente o nome do banco de dados, o usuário de acesso e a senha de acesso do banco do Postgresql do Dcm4chee.
- Quando publicar o dcm4chee em um servidor, deve liberar as portas 8080, 8443, 8843, 8880, 8990, 8993, 9990, 9993, 11112, 2762, 2575 e 12575. Não é necessário liberar a porta de acesso ao banco de dados (5432) e nem do ldap (389, 636).
