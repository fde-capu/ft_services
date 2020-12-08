#!/bin/sh
touch /MYSQL_CONTAINER
apk update
apk add mysql
mkdir -p /var/run/mysqld
chown mysql:mysql /var/run/mysqld
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
mysqld --user=mysql &
tail -f /dev/null
