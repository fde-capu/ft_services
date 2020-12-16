#!/bin/sh
touch /TELEGRAF_CONTAINER
set -e
if [ "${1:0:1}" = '-' ]; then
    set -- telegraf "$@"
fi
influxd &
exec "$@"


#tar -zxvf telegraf-* --strip 2
#mv telegraf.conf /etc/telegraf

#tail -f /dev/null
