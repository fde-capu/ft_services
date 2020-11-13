#!/bin/sh
php-fpm7
nginx -g "daemon off;" && tail -f /dev/null

#var_username="user42"
#var_userdomain="localhost"
#randomBlowfishSecret=$(openssl rand -base64 32)

#mysql -e "GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO '$var_username'@'$var_userdomain'"
#mysql -e "FLUSH PRIVILEGES"
#sed -e "s|cfg\['blowfish_secret'\] = ''|cfg['blowfish_secret'] = '$randomBlowfishSecret'|" /var/www/ft_server/html/phpmyadmin/config.sample.inc.php > /var/www/ft_server/html/phpmyadmin/config.inc.php
