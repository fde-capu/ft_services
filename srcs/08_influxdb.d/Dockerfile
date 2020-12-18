FROM		alpine:latest
ENV			TELEGRAF_VERSION 1.16.3
COPY		telegraf.conf /
RUN			set -e && \
			apk upgrade && \
			apk add wget influxdb && \
			wget -q https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz && \
			mkdir -p /usr/src /etc/telegraf && \
			tar -C /usr/src -xzf telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz && \
			rm -f /etc/telegraf/telegraf.conf && \
			ln -s /telegraf.conf /etc/telegraf/telegraf.conf && \
			mkdir /etc/telegraf/telegraf.d && \
			cp -a /usr/src/telegraf*/usr/bin/telegraf /usr/bin/
EXPOSE		8086
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
CMD			["telegraf"]
