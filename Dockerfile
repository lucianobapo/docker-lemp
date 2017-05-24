FROM alpine:3.5

MAINTAINER Luciano Porto <luciano.bapo@gmail.com> version: 0.3

LABEL Description="Webserver"

ENV PGDATA=/var/lib/postgresql/data

RUN apk add --no-cache \
      s6 \
      su-exec \
      openssh \
      openssl \
      nano \
      git \
      wget \
      curl \
      nginx \
      postgresql \
      php7 \
      php7-fpm \
      php7-ctype \
      php7-xml \
      php7-dom \
      php7-zip \
      php7-intl \
      php7-bz2 \
      php7-gd \
      php7-mcrypt \
      php7-json \
      php7-phar \
      php7-openssl \
      php7-session \
      php7-zlib \
      php7-pgsql \
      php7-pdo \
      php7-pdo_pgsql \
      php7-mbstring && \
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

RUN curl -sS https://getcomposer.org/installer | php7 -- --install-dir=/usr/bin --filename=composer

#RUN wget "https://github.com/vrana/adminer/releases/download/v4.3.1/adminer-4.3.1-en.php" -O /www/adminer.php

EXPOSE 8080

CMD ["run.sh"]