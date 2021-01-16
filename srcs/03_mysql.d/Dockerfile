FROM		alpine:latest
RUN			apk update
RUN			apk add mysql mysql-client
COPY		telegraf* /
COPY		wordpress.sql /
COPY		health_check.sh /
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
#CMD			["mysqld", "--user=user42"]
#ENTRYPOINT	["mysqld", "--user=user42"]
#ENTRYPOINT	["tail", "-f", "/dev/null"]
#RUN			/init.sh
#RUN			mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql && \
#			sleep 20
#RUN			/bin/sh /telegraf.sh
#RUN			mkdir -p /auth_pam_tool_dir/auth_pam_tool
#RUN			mkdir -p run/mysqld
#RUN			mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql
#ENTRYPOINT	["/usr/bin/mysqld_safe", "--datadir='/var/lib/mysql'"]
#RUN			/init.sh
