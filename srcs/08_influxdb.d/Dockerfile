FROM		alpine:latest
RUN			apk update
RUN			apk add influxdb
COPY		influxdb.conf /
RUN			rm -f /etc/influxdb.conf
COPY		telegraf* /
EXPOSE		8086
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
