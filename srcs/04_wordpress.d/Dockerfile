FROM		alpine:latest
COPY		server* /
COPY		wp_nginx.conf /
COPY		wp-config.php /
EXPOSE		5050
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
