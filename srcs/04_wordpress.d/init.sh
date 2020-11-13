#!/bin/sh
#echo "Hello, master!" > /var/www/html/index.htm
var_dbname="wordpress"
var_username="user42"
var_dbhost="mariadb"
var_userpassword="user42"
#randomBlowfishSecret=$(openssl rand -base64 32)

# configure MariaDB
mysql -e "UPDATE mysql.user SET PASSWORD('$var_rootpassword') WHERE User = 'root'"

# configure PHPMyAdmin
#mysql -e "GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO '$var_username'@'$var_userdomain'"
#mysql -e "FLUSH PRIVILEGES"
#sed -e "s|cfg\['blowfish_secret'\] = ''|cfg['blowfish_secret'] = '$randomBlowfishSecret'|" /var/www/ft_server/html/phpmyadmin/config.sample.inc.php > /var/www/ft_server/html/phpmyadmin/config.inc.php
#mysql < /var/www/ft_server/html/phpmyadmin/sql/create_tables.sql

# configure WordPress
#mysql -e "CREATE DATABASE $var_dbname"
#mysql -e "CREATE USER '$var_username'@'$var_userdomain' IDENTIFIED BY '$var_userpassword'"
#mysql -e "GRANT ALL PRIVILEGES ON $var_dbname.* TO '$var_username'@'$var_userdomain'"
#mysql -e "FLUSH PRIVILEGES"
echo "
 <?php
 define('DB_NAME', '$var_dbname');
 define('DB_USER', '$var_username');
 define('DB_PASSWORD', '$var_userpassword');
 define('DB_HOST', '$var_dbhost');
 define('DB_CHARSET', 'utf8');
 define('DB_COLLATE', '');
 define('AUTH_KEY',			'|||| These ||||////----____....');
 define('SECURE_AUTH_KEY',	'////|||| lines ----____....||||');
 define('LOGGED_IN_KEY',	'----////---- can be ...||||////');
 define('NONCE_KEY',		'____----****^^^^ literally ----');
 define('AUTH_SALT',		'.... anything .... any size ..-');
 define('SECURE_AUTH_SALT', '_______ Change these lines ____');
 define('LOGGED_IN_SALT',	'__ to reset all user sessions _');
 define('NONCE_SALT',		'|||||||||||||||||||||||||||||||');
 \$table_prefix = 'wp_';
 define('WP_DEBUG', false);
 define('FORCE_SSL_ADMIN', true);
 /* Do not edit below this line! */
 if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');
 require_once(ABSPATH . 'wp-settings.php');
" > /var/www/wordpress/wp-config.php;

php-fpm7 
nginx -g "daemon off;" && tail -f /dev/null
