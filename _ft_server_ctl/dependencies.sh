#!/bin/sh

# Foreplay
#sudo apt-get update # Uncomment this line for new installs
sudo apt-get install docker
sudo dockerd
sudo apt-get install virtualbox-6.1 
sudo apt install minikube

#kubectl:
sudo apt install apt-transport-https gnupg2 curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# kubectl autocompletion
echo 'source <(kubectl completion bash)' >>~/.bashrc
echo 'source ~/.bashrc'


echo "BIOS must have Virtualization ON."
