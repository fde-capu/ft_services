#!/bin/sh
touch /MYSQL_CONTAINER
set -e
mkdir -p /var/run/mysqld
mkdir -p /auth_pam_tool_dir/auth_pam_tool
chown mysql:mysql /var/run/mysqld
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
cat >> /etc/my.cnf.d/ft_services.cnf<<EOF
[mysqld]
skip-networking = 0
port = 3306
bind_address = 0.0.0.0
EOF
sed -i s/skip-networking*// /etc/my.cnf.d/mariadb-server.cnf
mysqld --user=mysql &
sleep 5
#mysql -e "CREATE DATABASE wordpress"
mysql -e "GRANT ALL ON *.* TO 'user42'@'%' IDENTIFIED BY 'user42' WITH GRANT OPTION"
mysql -e "FLUSH PRIVILEGES"
tail -f /dev/null
