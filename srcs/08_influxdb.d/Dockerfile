FROM		alpine:latest
RUN			apk update
RUN			apk add influxdb
#COPY		influxdb.conf /
COPY		telegraf.conf /
COPY		telegraf-1.16.3_static_linux_amd64.tar.gz /
RUN			mkdir -p /usr/src /etc/telegraf && \
			tar -C /usr/src -xzf telegraf-*.tar.gz && \
			rm -f /etc/telegraf/telegraf.conf && \
			mkdir /etc/telegraf/telegraf.d && \
			cp -a /usr/src/telegraf*/usr/bin/telegraf /usr/bin/ && \
			rm -f /etc/influxdb.conf
EXPOSE		8086
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
#CMD			["telegraf"]
