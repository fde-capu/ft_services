#!/bin/sh
sudo apt install lftp
rm -f $(dirname $0)/test-ok.txt
rm -f $(dirname $0)/ftps-test_file.txt
python3 $(dirname $0)/unit.py $(minikube ip) user42 user42
##                            ^ ip           ^user  ^password
