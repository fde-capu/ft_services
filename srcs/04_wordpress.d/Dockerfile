FROM		alpine:latest
COPY		latest.tar.gz /
RUN			apk update && \
			apk add nginx openssh php7 php7-fpm php7-opcache php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom && \
			df -h && \
			apk add wget mysql mysql-client && \
			#apk add php5-mysql
			echo "apk: yikes!";
RUN			tar -xzf /latest.tar.gz -C /var/www; \
			rm /latest.tar.gz; 
#			chown -R www-data:www-data /usr/src/wordpress; \
#			mkdir wp-content; \
#			chown -R www-data:www:data wp-content; \
#			chown -R 777 wp-content
VOLUME		/var/www/html
RUN			mkdir -p /run/nginx && \
			mkdir -p /etc/nginx/ssl && \
			ssh-keygen -A && \
			rm -f /etc/nginx/conf.d/default.conf
COPY		server* /etc/nginx/ssl/
COPY		wp_nginx.conf /etc/nginx/conf.d/
EXPOSE		5050
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
