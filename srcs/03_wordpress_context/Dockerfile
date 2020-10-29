FROM		alpine:3.12
RUN			wget wordpress.org/latest.tar.gz
RUN			mkdir -p /wordpress
RUN			tar -xf latest.tar.gz -C /
EXPOSE		5050
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
