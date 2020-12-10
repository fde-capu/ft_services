FROM		alpine:latest
COPY		server* /etc/nginx/ssl/
EXPOSE		22 80 443
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
