FROM		alpine:latest
RUN			mkdir -p /run/nginx && \
			mkdir -p /etc/nginx/ssl && \
			apk update && \
			apk add nginx openssh && \
			ssh-keygen -A && \
			rm -f /etc/nginx/conf.d/default.conf
COPY		server* /etc/nginx/ssl/
RUN			adduser -D user42 && \
			echo 'user42:user42' | chpasswd
EXPOSE		22 80 443
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
