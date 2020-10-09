fde-capu
===========
FT_SERVICES
===========

42 São Paulo
------------

Use `ctl/{cmd}` where `{cmd}` is:

- `run.sh` : makes everything (dind)
- `clean.sh` : removes ft_server container and ft_server image
- `o-clean-container.sh` : force remove ft_container
- `fclean(...).sh` : erases all images and container (caution)
- `it.sh` : logs into ft_server container shell
- `n-snap.sh` : creates a snapshot of the container under the name of fde-capu_ft_server
- `g-retake.sh` : retakes the snapshot created above
- `autoindex (x|on|off)` : swich autoindex inside the container
