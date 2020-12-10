#!/bin/sh
touch /GRAFANA_CONTAINER
apk update
apk add glib libc6-compat
wget https://dl.grafana.com/oss/release/grafana-$GRAFANA_VERSION.linux-amd64.tar.gz
tar -zxvf grafana-*.linux-amd64.tar.gz --strip 1
grafana-server &
tail -f /dev/null
