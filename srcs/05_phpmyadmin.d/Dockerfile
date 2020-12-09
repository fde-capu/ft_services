FROM		alpine:latest
COPY		server* /etc/nginx/ssl/
COPY		pma_nginx.conf /
COPY		config.inc.php /
EXPOSE		5000
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
