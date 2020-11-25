FROM		alpine:latest
RUN			apk update && \
			apk add vsftpd openssh
VOLUME		/var/lib/ftp
COPY		vsftpd.conf /etc/vsftpd/vsftpd.conf
RUN			mkdir -p /etc/ssl/private && \
			mkdir -p /etc/ssl/certs && \
			touch /var/log/vsftpd.log && \
			ssh-keygen -A
COPY		server.key /etc/ssl/private/
COPY		server.crt /etc/ssl/certs/
RUN			adduser -D user42 && \
			echo 'user42:user42' | chpasswd
EXPOSE		21
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
