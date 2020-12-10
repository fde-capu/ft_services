#!/bin/sh
touch /NGINX_CONTAINER
mkdir -p /run/nginx
mkdir -p /etc/nginx/ssl
apk update
apk add nginx openssh
ssh-keygen -A
rm -f /etc/nginx/conf.d/default.conf
adduser -D user42
echo 'user42:user42' | chpasswd
mkdir -p /www
echo "Nginx on /www from nginx-container." > /www/index.html
/usr/sbin/sshd &
nginx &
tail -f /dev/null
