# docker-lemp

sudo docker run -d -P --name web -p 80:80 -p 443:443 \
-v /home/ilhanet_lan/docker-lemp/var/log/nginx:/var/log/nginx \
-v /home/ilhanet_lan/docker-lemp/etc/php:/usr/local/etc \
-v /home/ilhanet_lan/docker-lemp/etc/nginx:/etc/nginx \
-v /home/ilhanet_lan/docker-lemp/var/www/html:/var/www/html \
-v /home/ilhanet_lan/docker-lemp/tmp:/host/tmp \
richarvey/nginx-php-fpm:latest

sudo docker run -d -P --name db -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret \
-v /home/ilhanet_lan/docker-lemp/var/lib/mysql:/var/lib/mysql \
mariadb:latest

