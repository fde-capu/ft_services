FROM		alpine:latest
RUN			apk update && \
			apk add vsftpd openssl
VOLUME		/var/lib/ftp
COPY		vsftpd.conf /etc/vsftpd/vsftpd.conf
RUN			mkdir -p /etc/ssl/private
COPY		etc-ssl-private-vsftpd.pem /etc/ssl/private/vsftpd.pem
RUN			adduser -D user42 && \
			echo 'user42:user42' | chpasswd
EXPOSE		21 30000
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
