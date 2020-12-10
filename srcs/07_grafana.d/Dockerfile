FROM		alpine:latest
ENV			GRAFANA_VERSION 7.3.5
COPY		influxdb-datasource.yml /
COPY		grafana-dashboard-provider.yml /
COPY		ft_services-dashboard.json /
COPY		grafana.ini /
COPY		server* /
EXPOSE		3000
COPY		init.sh /
ENTRYPOINT	["/init.sh"]
