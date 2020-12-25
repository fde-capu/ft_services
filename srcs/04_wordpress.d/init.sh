#!/bin/sh
touch /WORDPRESS_CONTAINER
set -e
ln -s /wp_nginx.conf /etc/nginx/conf.d/wp_nginx.conf
tar -zxvf wordpress.tar.gz -C /var/www
ln /wp-config.php /var/www/wordpress/wp-config.php
php-fpm7 &
nginx &
/bin/sh /telegraf.sh
tail -f /dev/null
