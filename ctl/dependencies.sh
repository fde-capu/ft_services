#!/bin/sh

# Foreplay
#sudo apt-get update # Uncomment this line for new installs
sudo apt-get install docker
sudo dockerd
sudo apt-get install virtualbox
sudo apt-get install snap snapd
sudo snap install minikube
sudo snap install --classic kubectl
echo 'export PATH="$PATH:/snap/bin"' >> ~/.profile
echo "\nPlease run \`source ~/.profile\`.\n"
