# dcm4chee-docker

Set all permissions in ./data

```bash
sudo chmod -R 777 ./data
```

Create and start the 4 containers by invoking:

```bash
docker-compose -p dcm4chee up -d
```

Stop all 4 containers:

```bash
docker-compose -p dcm4chee stop
```

Start all 4 containers:

```bash
docker-compose -p dcm4chee start
```

Destroy all 4 containers:

```bash
docker-compose -p dcm4chee down
```