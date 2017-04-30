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

sudo docker run -d -P --name teste -p 22 \
-e DEV_USER=dev \
-e DEV_PASSWORD=secret \
-e ROOT_PASSWORD=secret \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASSWORD=secret \
zyc9012/php-nginx-postgres:latest

