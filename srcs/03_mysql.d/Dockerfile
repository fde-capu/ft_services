FROM		alpine:latest
RUN			apk update
RUN			apk add mysql mysql-client
COPY		telegraf* /
COPY		init.sh /
COPY		wordpress.sql /
ENTRYPOINT	["/init.sh"]
#RUN			/init.sh
#ENTRYPOINT	["tail", "-f", "/dev/null"]
#RUN			/init.sh
#RUN			mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql && \
#			sleep 20
#ENTRYPOINT	["mysqld", "--user=root"]
#RUN			/bin/sh /telegraf.sh
#RUN			mkdir -p /auth_pam_tool_dir/auth_pam_tool
#RUN			mkdir -p run/mysqld
#RUN			mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql
#ENTRYPOINT	["/usr/bin/mysqld_safe", "--datadir='/var/lib/mysql'"]
#RUN			/init.sh
