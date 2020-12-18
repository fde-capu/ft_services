FROM		alpine:latest
RUN			apk update
RUN			apk add vsftpd openssl
COPY		vsftpd.conf /etc/vsftpd/vsftpd.conf
RUN			mkdir -p /etc/ssl/private && \
			mkdir -p /etc/ssl/certs
COPY		server* /
RUN			adduser -D user42 && \
			echo 'user42:user42' | chpasswd
EXPOSE		21
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
