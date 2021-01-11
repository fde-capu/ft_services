# ft_services
### fde-capu

It is an introduction study to Kubernetes.
The proposal:

![42 given cluster chart](https://github.com/fde-capu/ft_services/blob/master/chart.png "Cluster Chart Given by 42")

Specifications include:

- A `setup.sh` to... set things up.
- Dockerfiles written by me.
- One service for container.
- Use of Alpine Linux.
- nginx on ports 80 and 443 with auto-redirect from 80 to 443. Access through SSH on port 22.
- Single IP Load Balancer, only entry point. MetalLB recommended.
- WordPress on 5050 and redirect 307 from /wordpress.
- phpMyAdmin on port 5000 and reverse proxy from /phpmyadmin.
- MySQL.
- FTPS on port 21.
- Grafana monitoring all containers, on port 3000, linked to InfluxDB (on separate container). One dashboard per service.

FORBIDDEN:
- NodePort, Ingress Controller, kubectl port forward, DockerHub.

Let's get it on **clustering**!

#### Use:

- `./setup.sh` : resets Minikube and mount everything over. You must be sudo because of virtual-inside-virtual (`minikube driver=none`) setup.
- `ctl/logs.sh` : logs current Kubernetes status.
- `cd ctl && unit.sh` : run some tests. Requires python3 and lftp. Edit `ctl/unit.sh` to setup the default user and password.

#### Passwords:

|               | _user_  | _paswd_ |
| ------------- | ------- | ------- |
| nginx         | user42  | user42  |
| ftps          | user42  | user42  |
| mysql         | user42  | user42  |
| wordpress     | _unset_ | _unset_ |
| phpmyadmin    | user42  | user42  |
| grafana       | admin   | admin   |

#### Notes on dependencies:

- Minikube version < 10 does not support virtualization inside virtualization (at least on my Oracles Virtual Machine). For this reason, this project uses `--vm-drive=none`, this also implies Minikube must be sudo run. Please install the latest version and conntrack:

```
	curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	chmod +x minikube
	sudo mkdir -p /usr/local/bin
	sudo install minikube /usr/local/bin
	sudo apt install conntrack # for driver=none
```

- Check users and groups:

```
	sudo groupadd docker
	sudo usermod -aG docker user42
	newgrp docker
```

- Kill any running server:

```
	sudo pkill nginx
```

---

##### Considerations:

- Use `ssh user42@$(minikube ip)`; password: "user42".
- To login into ftps, use: `lftp $(minikube ip)`. Then `set ssl:verify-certificate no` and `user user42`; password: "user42".
- Three volumes are persistent and shared, the sql db, influx and /home (/home is accessible through ssh `nginx:22` and ftp `ftps`).
- mysql-client is installed on nginx for ease when interacting with `ssh -h mysql -uuser42 -puser42`.
- URL /grafana redirects to port 3000 (unrequested feature).
- Use `source <(kubectl completion zsh)` for extra adrenaline when interacting with `kubectl`.

---

*this project is part of the 42 São Paulo cursus*

---

Copyright 2020 fde-capu

This is how I made a Kjubernetes project, afterall, researching on the Internet. I am happy if you find it usefull to your studies. If you find anything profitable, do not use it without getting in touch, and we can work together.
