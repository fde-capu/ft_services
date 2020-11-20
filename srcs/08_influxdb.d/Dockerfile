FROM		alpine:latest
RUN			apk update && \
			echo "yikes!"
ENV			INFLUXDB_VERSION 1.7.10
RUN			wget https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz && \
			tar -zxvf influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz && \
			chmod +x influxdb-*/* && \
			cp -a influxdb-*/* /usr/bin/
VOLUME		/var/lib/influxdb
EXPOSE		8086
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
