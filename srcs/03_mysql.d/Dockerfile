FROM		alpine:latest
RUN			apk update && \
			apk add mysql mysql-client
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
