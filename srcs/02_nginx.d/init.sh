#!/bin/sh
touch /NGINX_CONTAINER
#adduser -D -g 'www' www
mkdir -p /www
#chown -R www:www /var/lib/nginx
#chown -R www:www /www
echo "Nginx on /www from nginx-container." > /www/index.html
/usr/sbin/sshd
nginx
tail -f /dev/null
