#!/bin/sh
export DEV_USER=${DEV_USER:-dev}
export DEV_PASSWORD=${DEV_PASSWORD:-dev}
export ROOT_PASSWORD=${ROOT_PASSWORD:-root}
export POSTGRES_USER=${POSTGRES_USER:-postgres}
export POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-postgres}

echo "root:${ROOT_PASSWORD}" | chpasswd > /dev/null 2>&1
echo -e "${DEV_PASSWORD}\n${DEV_PASSWORD}" | adduser ${DEV_USER} > /dev/null 2>&1
/usr/sbin/sshd -o PermitRootLogin=yes -o UseDNS=no
chown -R $DEV_USER:$DEV_USER /www /etc/nginx /usr/local/etc/php /var/log /var/lib/nginx /var/lib/postgresql /run/postgresql /tmp /etc/s6.d
rm -f /var/lib/postgresql/data/postmaster.pid
exec su-exec $DEV_USER:$DEV_USER /bin/s6-svscan /etc/s6.d
