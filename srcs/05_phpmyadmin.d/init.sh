#!/bin/sh

var_username="user42"
var_userdomain="localhost"
randomBlowfishSecret=$(openssl rand -base64 32)

mysql -e "GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO '$var_username'@'$var_userdomain'"
mysql -e "FLUSH PRIVILEGES"
sed -i -e "s|cfg\['blowfish_secret'\] = ''|cfg['blowfish_secret'] = '$randomBlowfishSecret'|" /var/www/webapps/phpmyadmin/config.inc.php

php-fpm7
nginx
tail -f /dev/null
