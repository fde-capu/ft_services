FROM		alpine:latest
COPY		server* /etc/nginx/ssl/
RUN			touch /NGINX_CONTAINER					&& \
			apk update								&& \
			apk add nginx openssh mysql-client curl	&& \
			mkdir -p /run/nginx						&& \
			mkdir -p /etc/nginx/ssl					&& \
			ssh-keygen -A							&& \
			rm -f /etc/nginx/conf.d/default.conf	&& \
			adduser -D user42						&& \
			echo 'user42:user42' | chpasswd			&& \
			mkdir -p /www							&& \
			echo "Nginx on /www from nginx-container." > /www/index.html
EXPOSE		22 80 443
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
