#!/bin/sh
#adduser -D -g 'www' www
mkdir -p /www
#chown -R www:www /var/lib/nginx
#chown -R www:www /www
echo "Nginx is on" > /www/index.html
/usr/sbin/sshd
nginx
tail -f /dev/null
