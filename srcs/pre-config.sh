#!/bin/sh

echo "\n\nFT_SERVICES\nby fde-capu\n\npre-config\n=========\n"

# VM42 needs 2 CPUs
# VM Specs:
# Ubuntu 64b
# Nested VT-x/AMD-V
# Default Paravirtualization
# Enabled Nested Paging
# Oracle Extension Pack 6.1.14
# may need to:
### sudo usermod -aG docker user42
### sudo apt install -y ssh
### sudo pkill nginx

echo -n "Do you want to \`sudo apt update && sudo apt upgrade\`? ... you may need to manually run these commands a bunch of times until there is nothing else to upgrade. (y/N)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
	sudo apt update
	sudo apt upgrade
fi

echo -n "Install 'conntrack'? This MUST be installed for the 'none' minikube driver to work. (y/N)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
	sudo apt install -y conntrack
fi

echo -n "Do you want to download and install the latest Google release of 'minikube'? This must be done to enable metallb. (y/N)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
	curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	chmod +x minikube
	sudo mkdir -p /usr/local/bin
	sudo install minikube /usr/local/bin
fi

echo -n "Set user42:docker permission for /var/var/docker.sock? This is also a must. (y/N)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
	sudo chown user42:docker /var/run/docker.sock
fi

echo -n "Do you want to reset minikube caches (y/N)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
	sudo minikube delete
	sudo rm -rf ~/.minikube
fi

echo -n "Do you want to wipe clean the docker images and containers on this machine (y/N)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
	docker rm -f `docker ps -aq`
	docker rmi -f `docker images -aq`
fi

echo -n "Erase any previous volumes on /ft_services-fde-capu (y/N)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
	sudo rm -rf /ft_services-fde-capu
fi

echo "\n\npre-configuration done.\n\n"
sleep 1
