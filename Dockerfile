FROM php:7.1-fpm-alpine

MAINTAINER Luciano Porto <luciano.bapo@gmail.com> version: 0.4

LABEL Description="Webserver"

ENV PGDATA=/var/lib/postgresql/data

RUN apk update && apk upgrade && apk add --no-cache \
      s6 \
      su-exec \
      openssh \
      openssl \
      nano \
      git \
      wget \
      curl \
      nginx \
      postgresql && \
    mkdir -p /www && \
    mkdir -p $PGDATA && chmod 0755 $PGDATA && \
    mkdir -p /run/postgresql && chmod g+s /run/postgresql && \
    echo "<?php phpinfo(); ?>" > /www/index.php && \
    ssh-keygen -A && \
    rm -f /var/cache/apk/*

COPY etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY etc/php7/php-fpm.conf /etc/php7/php-fpm.conf
COPY tmp/run.sh /usr/local/bin/run.sh
COPY tmp/s6.d /etc/s6.d

RUN chmod +x /usr/local/bin/run.sh /etc/s6.d/*/* /etc/s6.d/.s6-svscan/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

#RUN wget "https://github.com/vrana/adminer/releases/download/v4.3.1/adminer-4.3.1-en.php" -O /www/adminer.php

EXPOSE 8080 443 22 5432

CMD ["run.sh"]