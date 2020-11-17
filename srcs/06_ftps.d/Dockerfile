FROM		alpine:latest
RUN			apk update && \
			apk add openssh vsftpd
RUN			ssh-keygen -A
EXPOSE		21
VOLUME		/var/lib/ftp
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
