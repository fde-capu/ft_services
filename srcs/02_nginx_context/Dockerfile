FROM		alpine:3.12
RUN			mkdir -p /run/nginx && \
			apk update && \
			apk add nginx openssh && \
			mkdir -p /etc/nginx/ssl && \
			ssh-keygen -A
COPY		server* /etc/nginx/ssl/
COPY		init.sh /
EXPOSE		22 80 443
ENTRYPOINT	["/init.sh"]
