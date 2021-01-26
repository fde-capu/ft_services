#!/bin/sh
touch /GRAFANA_CONTAINER
set -e
tar -zxvf grafana-*.linux-amd64.tar.gz --strip 1
mkdir -p /var/lib/grafana/dashboards
ln -s /influxdb-datasource.yml /conf/provisioning/datasources/influxdb-datasource.yml
ln -s /grafana-dashboard-provider.yml /conf/provisioning/dashboards/grafana-dashboard-provider.yml
sed -e 's/{HOSTNAME}/ftps/' -e 's/{DASHUID}/fdecapuftps/' <ft_services.json > /var/lib/grafana/dashboards/ftps.json
sed -e 's/{HOSTNAME}/influxdb/' -e 's/{DASHUID}/fdecapuinfluxdb/' <ft_services.json > /var/lib/grafana/dashboards/influxdb.json
sed -e 's/{HOSTNAME}/grafana/' -e 's/{DASHUID}/fdecapugrafana/' <ft_services.json > /var/lib/grafana/dashboards/grafana.json
sed -e 's/{HOSTNAME}/phpmyadmin/' -e 's/{DASHUID}/fdecapuphpmyadmin/' <ft_services.json > /var/lib/grafana/dashboards/phpmyadmin.json
sed -e 's/{HOSTNAME}/wordpress/' -e 's/{DASHUID}/fdecapuwordpress/' <ft_services.json > /var/lib/grafana/dashboards/wordpress.json
sed -e 's/{HOSTNAME}/mysql/' -e 's/{DASHUID}/fdecapumysql/' <ft_services.json > /var/lib/grafana/dashboards/mysql.json
sed -e 's/{HOSTNAME}/nginx/' -e 's/{DASHUID}/fdecapunginx/'  <ft_services.json > /var/lib/grafana/dashboards/nginx.json
grafana-server --config /grafana.ini &
/bin/sh /telegraf.sh &
exec /bin/sh /health_check.sh grafana telegraf
