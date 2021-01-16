#!/bin/sh
set -x
while true
do
	sleep 3
	for inspect in "$@"
	do
		if ! pgrep "$inspect" ; then
			exit 1
		fi
	done
done
exit 2
