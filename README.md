fde-capu
--------
FT_SERVICES
===========

42 São Paulo
------------
This is the current project I am working on.
It is an introduction to Kubernetes.
The proposal is sumarized on this chart:

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
- Grafana monitoring all containers, on port 3000, linked with InfluxDB (on separate container). One dashboard por service.

FORBIDDEN:
- NodePort, Ingress Controller, kubectl por forward, DockerHub.

It seems unfinished. Because it is.
Let's get it on **clustering**!

Use `ctl/{cmd}` where `{cmd}` is:
- `status.sh` : logs everything.
