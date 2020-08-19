# Manual de instalação do dcm4che 5

Este manual ajuda qualquer usuário na criação de ambiente do dcm4che 5.

## Pré-requisitos

É necessário ter instalado os seguintes softwares:

- Docker (https://docs.docker.com/engine/install/)
- Docker Compose (https://docs.docker.com/compose/install/)

## Instalação

1. Adicione __dcm4che__ no arquivo "hosts"(`C:\Windows\System32\Drivers\etc\hosts`):

```bash
127.0.0.1	dcm4che
```

2. Altere o host __dcm4che__ das linhas 2 e 3 do arquivo `dcm4che/docker-compose.env` para o nome do host (somente para sistemas que serão acessados externamente).

3. Suba o ambiente docker:

```bash
docker-compose -p dcm4chee up -d
```

4. Crie um serviço para iniciar o computador com o ambiente iniciado.

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