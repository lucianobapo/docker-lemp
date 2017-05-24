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
-v /home/luciano/code/docker-lemp/tmp:/host/tmp \
-e DEV_USER=dev \
-e DEV_PASSWORD=secret \
-e ROOT_PASSWORD=secret \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASSWORD=secret \
zyc9012/php-nginx-postgres:latest



php-fpm7 -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

docker rmi $(docker images |awk '{print $3}')

docker kill $(docker ps |awk '{print $1}')

docker volume rm $(docker volume ls |awk '{print $2}')

CREATE USER erpnetv5 WITH PASSWORD erpnetv5;
CREATE DATABASE erpnetv5;
GRANT ALL PRIVILEGES ON DATABASE erpnetv5 to erpnetv5;

CREATE USER "tigresav_ppm" WITH PASSWORD 'tigresav_ppm';
CREATE DATABASE "tigresav_ppm";
GRANT ALL PRIVILEGES ON DATABASE "tigresav_ppm" to "tigresav_ppm";

