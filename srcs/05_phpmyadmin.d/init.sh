#!/bin/sh
touch /PHPMYADMIN_CONTAINER
set -e
rm -f /usr/share/webapps/phpmyadmin/config.inc.php
ln -s /usr/share/webapps/phpmyadmin /var/www
ln -s /pma_nginx.conf /etc/nginx/conf.d/pma_nginx.conf
ln -s /config.inc.php /usr/share/webapps/phpmyadmin/config.inc.php
chmod 644 /usr/share/webapps/phpmyadmin/config.inc.php
ln /server.key /etc/nginx/ssl/server.key
ln /server.crt /etc/nginx/ssl/server.crt
php-fpm7 &
nginx &
/bin/sh /telegraf.sh &
exec /bin/sh /health_check.sh php-fpm7 nginx telegraf
