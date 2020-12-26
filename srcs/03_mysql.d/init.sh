#!/bin/sh
touch /MYSQL_CONTAINER
set -e
adduser -D user42
#echo 'user42:user42' | chpasswd
chown user42:root /var/lib/mysql
mkdir -p /auth_pam_tool_dir/auth_pam_tool
chown user42:root /auth_pam_tool_dir/auth_pam_tool
#chown user42:root /var/lib/mysql
mysql_install_db --user=user42 --basedir=/usr --datadir=/var/lib/mysql
mkdir -p /var/run/mysqld
chown user42:root /var/run/mysqld
#cat >> /etc/my.cnf.d/ft_services.cnf<<EOF
#[mysqld]
#skip-networking = 0
#port = 3306
#bind_address = 0.0.0.0
#EOF
#sed -i s/skip-networking*// /etc/my.cnf.d/mariadb-server.cnf
#mysqld --user=mysql &
#sleep 5
##mysql -e "CREATE DATABASE wordpress"
#mysql -e "GRANT ALL ON *.* TO 'user42'@'%' IDENTIFIED BY 'user42' WITH GRANT OPTION"
#mysql -e "FLUSH PRIVILEGES"
/bin/sh /telegraf.sh
