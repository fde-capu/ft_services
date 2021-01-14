FROM		alpine:latest
RUN			apk update
RUN			apk add nginx
RUN			apk add openssh	mysql-client curl
COPY		server* /
COPY		nginx.conf /
RUN			mkdir -p /run/nginx						&& \
			mkdir -p /etc/nginx/ssl					&& \
			ssh-keygen -A							&& \
			rm -f /etc/nginx/conf.d/default.conf	&& \
			adduser -D user42						&& \
			echo 'user42:user42' | chpasswd			&& \
			mkdir -p /www							&& \
			echo "Nginx on /www from nginx-container." > /www/index.html
COPY		telegraf* /
EXPOSE		22 80 443
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
