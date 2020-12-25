FROM		alpine:latest
RUN			apk update
RUN			apk add mysql mysql-client
COPY		telegraf* /
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
