#!/bin/sh
touch /GRAFANA_CONTAINER
apk update
apk add glib libc6-compat
wget https://dl.grafana.com/oss/release/grafana-$GRAFANA_VERSION.linux-amd64.tar.gz
tar -zxvf grafana-*.linux-amd64.tar.gz --strip 1
mv influxdb-datasource.yml /conf/provisioning/datasources
mv grafana-dashboard-provider.yml /conf/provisioning/dashboards
# not sure if its correct directory:
mkdir -p /var/lib/grafana/dashboards
mv ft_services-dashboard.json /var/lib/grafana/dashboards
mv grafana.ini /conf
rm /conf/sample.ini
grafana-server &
tail -f /dev/null
