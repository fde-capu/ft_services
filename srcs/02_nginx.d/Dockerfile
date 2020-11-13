FROM		alpine:latest
RUN			mkdir -p /run/nginx && \
			apk update && \
			apk add nginx openssh && \
			mkdir -p /etc/nginx/ssl && \
			ssh-keygen -A && \
			rm -f /etc/nginx/conf.d/default.conf
COPY		server* /etc/nginx/ssl/
COPY		nginx.conf /etc/nginx/conf.d/
EXPOSE		22 80 443
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
