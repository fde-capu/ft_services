FROM		alpine:3.12
RUN			apk update && \
			apk add mysql mysql-client
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
