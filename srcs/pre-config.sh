#!/bin/sh

echo "\n\nFT_SERVICES\nby fde-capu\n\npre-config\n=========\n"
sudo touch sudo_test
sudo rm sudo_test

# VM42 needs 2 CPUs
# VM Specs:
# Ubuntu 64b
# Nested VT-x/AMD-V
# Default Paravirtualization
# Enabled Nested Paging
# Oracle Extension Pack 6.1.14
# may need to:
### sudo apt install -y ssh
### sudo pkill nginx
# for the 42 VM Machine:
# sudo apt remove unattended-upgrades

if pgrep nginx >> /dev/null ;
then
	echo -n "\nNginx is running. \`pkill nginx\`? This should avoid conflict. (y/N)? "
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
		sudo pkill nginx
	fi
fi

echo -n "\nDo you want to \`sudo apt update && sudo apt upgrade\`? ... you may need to manually run these commands a bunch of times until there is nothing else to upgrade. (y/N)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
	sudo apt update
	sudo apt upgrade
fi

echo "\n"
if ! dpkg -s conntrack >> /dev/null ;
then
	echo -n "Install 'conntrack'? This MUST be installed for the 'none' minikube driver to work. (y/N)? "
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
		sudo apt install -y conntrack
	fi
fi

echo -n "\nYour `minikube version | head -1`\nDo you want to download and install the latest Google release of 'minikube'? This must be done to enable metallb. This project is tested under v1.17.0. (y/N)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
	curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	chmod +x minikube
	sudo mkdir -p /usr/local/bin
	sudo install minikube /usr/local/bin
fi

echo -n "\nDo you want to reset minikube caches (y/N)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
	sudo minikube delete
	sudo rm -rf ~/.minikube
fi

echo -n "\nDo you want to wipe clean the docker images and containers on this machine (y/N)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
	sudo usermod -aG docker user42
	sudo chown user42:docker /run/docker.sock
	ls -l /run/docker.sock
	docker rm -f `docker ps -aq` >> /dev/null
	docker rmi -f `docker images -aq` >> /dev/null
fi

echo -n "\nErase any previous volumes on /ft_services-fde-capu (y/N)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
	sudo rm -rf /ft_services-fde-capu
fi

echo "\n\npre-configuration done.\n\n"
sleep 1
echo -n "T-10"
sleep 1
echo -n "\b\b9 "
sleep 1
echo -n "\b\b8 "
sleep 1
echo -n "\b\b7 "
sleep 1
echo -n "\b\b6 "
sleep 1
echo -n "\b\b5 "
sleep 1
echo -n "\b\b4 "
sleep 1
echo -n "\b\b3 "
sleep 1
echo -n "\b\b2 "
sleep 1
echo -n "\b\b1 "
sleep 1
echo -n "\b\b0 "
