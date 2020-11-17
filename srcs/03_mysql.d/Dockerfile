FROM		alpine:latest
RUN			apk update && \
			apk add mysql mysql-client
VOLUME		/mnt/mysql
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
