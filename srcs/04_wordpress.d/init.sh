#!/bin/sh
touch /WORDPRESS_CONTAINER
set -e
ln -s /wp_nginx.conf /etc/nginx/conf.d/wp_nginx.conf
tar -zxvf wordpress.tar.gz -C /var/www
mv /wp-config.php /var/www/wordpress
php-fpm7 &
nginx &
tail -f /dev/null
