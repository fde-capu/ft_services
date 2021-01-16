#!/bin/sh
touch /WORDPRESS_CONTAINER
set -e
ln /server.key /etc/nginx/ssl/server.key
ln /server.crt /etc/nginx/ssl/server.crt
ln -s /wp_nginx.conf /etc/nginx/conf.d/wp_nginx.conf
tar -zxvf wordpress.tar.gz -C /var/www
ln /wp-config.php /var/www/wordpress/wp-config.php
/bin/sh /telegraf.sh &
php-fpm7 & nginx &
sleep 10
exec /bin/sh /health_check.sh php-fpm7 nginx
