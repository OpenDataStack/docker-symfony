FROM ubuntu:16.04
MAINTAINER Willie Seabrook<willie@angrycactus.io>

# No tty
ENV DEBIAN_FRONTEND noninteractive

# Basic Requirements
RUN apt-get update && apt-get -y install \
  nano \
  php-fpm php-xml php-mbstring php-bcmath \
  nginx \
  supervisor

# Nginx
COPY ./config/nginx/default.conf /etc/nginx/sites-available/default

# Supervisor
RUN mkdir -p /run/php/
COPY config/supervisord/supervisord.conf /etc/supervisor/supervisord.conf
COPY config/supervisord/conf.d/ /etc/supervisor/conf.d/

# PHP
COPY config/php/fpm/php.ini /etc/php/7.0/fpm/php.ini
COPY config/php/fpm/pool.d/www.conf /etc/php/7.0/fpm/pool.d/www.conf

COPY ./scripts/start.sh /start.sh
RUN chmod 755 /start.sh

EXPOSE 80

VOLUME ["/usr/share/nginx/www"]

CMD ["/bin/bash", "/start.sh"]
