FROM		alpine:latest
ENV			INFLUXDB_VERSION 1.7.10
VOLUME		/var/lib/influxdb
EXPOSE		8086
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
