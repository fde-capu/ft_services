FROM		alpine:latest
RUN			apk update
RUN			apk add mysql mysql-client
COPY		telegraf* /
COPY		init.sh /
RUN			adduser -D user42 && \
			mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql && \
			mkdir -p /var/run/mysqld
RUN			/init.sh
ENTRYPOINT	["mysqld", "--user=root"]
#ENTRYPOINT	["tail", "-f", "/dev/null"]
