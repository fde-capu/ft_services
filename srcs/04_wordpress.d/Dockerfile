FROM		alpine:latest
COPY		server* /etc/nginx/ssl/
COPY		wp_nginx.conf /etc/nginx/conf.d/
COPY		wp-config.php /var/www/wordpress/
EXPOSE		5050
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
