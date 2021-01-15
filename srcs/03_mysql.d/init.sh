#!/bin/sh
touch /MYSQL_CONTAINER
set -x
mkdir -p /auth_pam_tool_dir/auth_pam_tool
mkdir -p run/mysqld
cat >> /etc/my.cnf.d/ft_services.cnf<<EOF
[mysqld]
skip-networking = 0
port = 3306
bind_address = 0.0.0.0
EOF
sed -i s/skip-networking*// /etc/my.cnf.d/mariadb-server.cnf

adduser -D user42
echo 'user42:user42' | chpasswd
chown user42:root /var/lib/mysql
chown user42:root /auth_pam_tool_dir/auth_pam_tool
chown user42:root /var/run/mysqld
#chown user42:root ??

mysql_install_db --user=user42 --basedir=/usr --datadir=/var/lib/mysql
mysqld --user=user42 &
while [ ! -S /var/run/mysqld/mysqld.sock ]; do
	echo -n '.'
	sleep 1
done
mysql -e "CREATE DATABASE wordpress"
mysql "--user=root" "--password=" wordpress < /wordpress.sql
mysql -e "GRANT ALL ON *.* TO 'user42'@'%' IDENTIFIED BY 'user42' WITH GRANT OPTION"

#exec mysqld --user=user42
tail -f /dev/null

#mysql -e "FLUSH PRIVILEGES"
#sleep 5
#/bin/sh /telegraf.sh
