#!/bin/sh

python3 unit.py $(minikube ip) user42 user42
##              ^ ip           ^user  ^password

# curl $ip
# curl $ip:443

