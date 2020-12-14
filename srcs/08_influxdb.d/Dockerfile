FROM		alpine:latest
ENV			TELEGRAF telegraf-1.16.3_linux_amd64
COPY		telegraf.conf /
EXPOSE		8086
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
