#!/bin/sh
touch /NGINX_CONTAINER
set -e
ln /server.key /etc/nginx/ssl/server.key
ln /server.crt /etc/nginx/ssl/server.crt
ln /nginx.conf /etc/nginx/conf.d/nginx.conf
/usr/sbin/sshd &
nginx &
/bin/sh /telegraf.sh &
exec /bin/sh /health_check.sh sshd nginx telegraf
