# ft_services
### fde-capu

It is an introduction study to Kubernetes.
The proposal:

![42 given cluster chart](https://github.com/fde-capu/ft_services/blob/master/chart.png "Cluster Chart Given by 42")

Some of the specifications include:

- A `setup.sh` to... set things up.
- Dockerfiles written by me.
- One service for container.
- Use of Alpine Linux.
- Single IP Load Balancer, only entry point. MetalLB recommended.
- WordPress on 5050 and redirect 307 from /wordpress.
- MySQL.
- phpMyAdmin on port 5000 and redirect reverse proxy8 from /phpmyadmin.
- nginx on ports 80 and 443 with auto-redirect from 80 to 443. Access through SSH.
- FTPS on port 21.
- Grafana monitoring all containers, on port 3000, linked with InfluxDB (on separate container). One dashboard per service.

FORBIDDEN:
- NodePort, Ingress Controller, kubectl port forward, DockerHub.

It seems unfinished. Because it is.
Let's get it on **clustering**!

Use `ctl/{cmd}` where `{cmd}` is:
- `status.sh` : logs everything.

---

*this project is part of the 42 São Paulo cursus*

---

Copyright 2020 fde-capu

This is how I made a Kjubernetes project, afterall, researching on the Internet. I am happy if you find it usefull to your studies. If you find anything profitable, do not use it without getting in touch, and we can work together.
