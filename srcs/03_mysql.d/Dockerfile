FROM		alpine:latest
RUN			apk update
RUN			apk add mysql mysql-client
COPY		telegraf* /
COPY		init.sh /
RUN			/init.sh
ENTRYPOINT	["mysqld", "--user=user42"]
#ENTRYPOINT	["tail", "-f", "/dev/null"]
