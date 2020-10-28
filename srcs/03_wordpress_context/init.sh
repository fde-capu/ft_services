#!/bin/sh
var_dbname="ft_db"
var_username="ft_user"
var_userdomain="localhost"
var_userpassword="passwd42sp"
var_pathtowordpress="/wordpress"

# configure WordPress
echo "
 <?php
 define('DB_NAME', '$var_dbname');
 define('DB_USER', '$var_username');
 define('DB_PASSWORD', '$var_userpassword');
 define('DB_HOST', '$var_userdomain:/var/run/mysqld/mysqld.sock');
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
 define('WP_SITEURL', 'http://$var_userdomain$var_pathtowordpress');
 define('WP_HOME', 'http://$var_userdomain$var_pathtowordpress');
 define('FORCE_SSL_ADMIN', true);
 /* Do not edit below this line! */
 if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');
 require_once(ABSPATH . 'wp-settings.php');
" > /wp-config.php;
tail -f /dev/null
