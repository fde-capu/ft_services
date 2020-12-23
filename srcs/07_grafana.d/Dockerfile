FROM		alpine:latest
RUN			apk update
RUN			apk add glib libc6-compat
COPY		grafana-7.3.5.linux-amd64.tar.gz /
COPY		influxdb-datasource.yml /
COPY		grafana-dashboard-provider.yml /
COPY		ft_services-*.json /
COPY		grafana.ini /
COPY		server* /
COPY		telegraf* /
EXPOSE		3000
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
