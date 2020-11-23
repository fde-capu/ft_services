FROM		alpine:latest
RUN			mkdir -p /run/nginx && \
			apk update && \
			apk add nginx openssh sudo && \
			mkdir -p /etc/nginx/ssl && \
			ssh-keygen -A && \
			rm -f /etc/nginx/conf.d/default.conf
COPY		server* /etc/nginx/ssl/
COPY		nginx.conf /etc/nginx/conf.d/
RUN			adduser user42 -D && \
			echo 'user42:user42' | chpasswd
EXPOSE		22 80 443
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
