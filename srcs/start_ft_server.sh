#!/bin/bash

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start_ft_server.sh                                 :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fde-capu <fde-capu@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/04/06 18:05:53 by fde-capu          #+#    #+#              #
#    Updated: 2020/04/06 18:05:53 by fde-capu         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

var_dbname="ft_db"
var_rootpassword="rootpassword"
var_username="ft_user"
var_userdomain="localhost"
var_userpassword="passwd42sp"
var_pathtowordpress="/wordpress"
randomBlowfishSecret=$(openssl rand -base64 32)

service nginx start
service mysql start
service $(find /etc/init.d -name 'php*' | sed 's/.*\///') start

# configure MariaDB
mysql -e "UPDATE mysql.user SET PASSWORD('$var_rootpassword') WHERE User = 'root'"

# configure PHPMyAdmin
mysql -e "GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO '$var_username'@'$var_userdomain'"
mysql -e "FLUSH PRIVILEGES"
sed -e "s|cfg\['blowfish_secret'\] = ''|cfg['blowfish_secret'] = '$randomBlowfishSecret'|" /var/www/ft_server/html/phpmyadmin/config.sample.inc.php > /var/www/ft_server/html/phpmyadmin/config.inc.php
mysql < /var/www/ft_server/html/phpmyadmin/sql/create_tables.sql

# configure WordPress
mysql -e "CREATE DATABASE $var_dbname"
mysql -e "CREATE USER '$var_username'@'$var_userdomain' IDENTIFIED BY '$var_userpassword'"
mysql -e "GRANT ALL PRIVILEGES ON $var_dbname.* TO '$var_username'@'$var_userdomain'"
mysql -e "FLUSH PRIVILEGES"
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
" > /var/www/ft_server/html$var_pathtowordpress/wp-config.php;

# security issues
mkdir -p /var/www/ft_server/html/phpmyadmin/tmp
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*
chmod -R 700 /var/www/ft_server/html/phpmyadmin/tmp

# comment lines below if you don't want to feed ft_db with test values
mysql -e "USE ft_db;"
mysql -e "CREATE TABLE squad (name VARCHAR(20), id42 VARCHAR(20));"
mysql -e "INSERT INTO squad (name, id42) VALUES ('Caio Vinicius','csouza-f'), ('Flavio','fde-capu'), ('Mariana','msoares'), ('Miguel','mtaiar-s');"

# maybe you want to erase this sensible file
# rm ./start_ft_server.sh

# read reverse fixedly from null void (keeps container alive!)
tail -f /dev/null
