#!/bin/sh
touch /GRAFANA_CONTAINER
set -e
tar -zxvf grafana-*.linux-amd64.tar.gz --strip 1
mkdir -p /var/lib/grafana/dashboards
ln -s /influxdb-datasource.yml /conf/provisioning/datasources/influxdb-datasource.yml
ln -s /grafana-dashboard-provider.yml /conf/provisioning/dashboards/grafana-dashboard-provider.yml
ln -s /ft_services-*.json /var/lib/grafana/dashboards/
grafana-server --config /grafana.ini &
/bin/sh /telegraf.sh
tail -f /dev/null
