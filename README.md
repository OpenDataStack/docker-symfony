## Summary

A Dockerfile for simple Symfony app container

- Based on ubuntu:16.04 for developer simplicity (not size)
- With nginx + php-fpm
- With rabbit-mq via php-enqueue/ampq
- Custom nginx, php and supervisord configurations
- Without a database

## Usage

### Variables

- $WWW_UID and $WWW_GID : Optional to change the UID/GID that nginx runs under to
solve permission issues if you are mounting a directory from your host

### Running

Pull from docker hub and run:

```
docker pull opendatastack/docker-symfony
docker run \
-e "WWW_UID=1000" \
-e "WWW_GID=1000" \
-e "APP_ELASTIC_SERVER_HOST=http://anotherurl:9400" \
-p 80:80 \
-v /PATH/TO/YOUR/SYMFONY/APP:/var/www/project/ \
--name docker-symfony opendatastack/docker-symfony;
```

## Development & Test Cycle

Download: ```git clone git@github.com:OpenDataStack/docker-symfony.git && cd docker-symfony```

Change:

```
docker rm docker-symfony;
docker build -t docker-symfony .;
docker run \
-e "WWW_UID=1000" \
-e "WWW_GID=1000" \
-e "APP_ELASTIC_SERVER_HOST=http://anotherurl:9400" \
-p 80:80 \
-v /PATH/TO/YOUR/SYMFONY/APP:/var/www/project/ \
--name docker-symfony docker-symfony:latest;
```

Commit and push:

```
docker login
docker tag docker-symfony opendatastack/docker-symfony
docker push opendatastack/docker-symfony
```

### Debugging

Login:

```
docker exec -it docker-symfony /bin/bash
```

Copy files from the container:

```
docker cp docker-symfony:/etc/php/7.0/fpm/php.ini /PATH/TO/FILE
```
