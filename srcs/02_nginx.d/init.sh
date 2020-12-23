#!/bin/sh
touch /NGINX_CONTAINER
set -e
ln /server.key /etc/nginx/ssl/server.key
ln /server.crt /etc/nginx/ssl/server.crt
/usr/sbin/sshd &
nginx &

/bin/sh /telegraf.sh

tail -f /dev/null
