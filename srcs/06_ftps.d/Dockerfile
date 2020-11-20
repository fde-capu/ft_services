FROM		alpine:latest
RUN			apk update && \
			apk add vsftpd openssl
EXPOSE		21
VOLUME		/var/lib/ftp
COPY		vsftpd.conf /etc/vsftpd/vsftpd.conf
RUN			mkdir -p /etc/ssl/private
COPY		etc-ssl-private-vsftpd.pem /etc/ssl/private/vsftpd.pem
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
