FROM alpine:latest
ENV TELEGRAF_VERSION 1.16.3
RUN set -ex && \
	apk upgrade && \
    apk add wget influxdb && \
    wget https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz && \
    mkdir -p /usr/src /etc/telegraf && \
    tar -C /usr/src -xzf telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz && \
    mv /usr/src/telegraf*/etc/telegraf/telegraf.conf /etc/telegraf/ && \
    mkdir /etc/telegraf/telegraf.d && \
    cp -a /usr/src/telegraf*/usr/bin/telegraf /usr/bin/ && \
	echo 'yikes'
EXPOSE 8086
COPY		init.sh /
ENTRYPOINT ["/init.sh"]
CMD ["telegraf"]
