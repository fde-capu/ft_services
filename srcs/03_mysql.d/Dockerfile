FROM		alpine:3.12
RUN			apk update
RUN			apk add mysql mysql-client
COPY		telegraf* /
COPY		wordpress.sql /
COPY		health_check.sh /
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
