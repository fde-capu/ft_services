FROM		alpine:latest
RUN			apk update
RUN			apk add mysql mysql-client
COPY		telegraf* /
COPY		init.sh /
RUN			adduser -D user42 && \
			chown user42:root /var/lib/mysql && \
			mkdir -p /auth_pam_tool_dir/auth_pam_tool && \
			chown user42:root /auth_pam_tool_dir/auth_pam_tool && \
			mysql_install_db --user=user42 --basedir=/usr --datadir=/var/lib/mysql && \
			mkdir -p /var/run/mysqld && \
			chown user42:root /var/run/mysqld
RUN			/init.sh
ENTRYPOINT	["mysqld", "--user=user42"]
#ENTRYPOINT	["tail", "-f", "/dev/null"]
