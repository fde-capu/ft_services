# FT_SERVICES
### fde-capu

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

*this project is part of the 42 São Paulo cursus*

Copyright 2020 fde-capu

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
