#!/bin/sh
set -e
mkdir -p /usr/src /etc/telegraf
tar -C /usr/src -xzf telegraf-*.tar.gz
rm -f /etc/telegraf/telegraf.conf
mkdir /etc/telegraf/telegraf.d
cp -a /usr/src/telegraf*/usr/bin/telegraf /usr/bin/
exec telegraf -config /telegraf.conf &
