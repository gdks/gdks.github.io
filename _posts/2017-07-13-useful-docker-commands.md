---
title: Useful Docker Commands
description: Useful Docker Commands
header: Useful Docker Commands
---

Cleaning up

> docker system prune [-a]

> docker images prune

> docker containers prune

> docker rm $(docker ps --no-trunc -aq)


Connect to running container

> docker exec -it containerid /bin/bash

> docker exec -it containerid /bin/sh

> docker attach containerid

Build image from Dockerfile

> docker build -t containername -f /path/to/Dockerfile .

Run mounting Docker socket to host

> docker run -it -v /var/run/docker.sock:/var/run/docker.sock containername

Run mounting host directory to container

> docker run -it -v ~/host/path/:/container/path/ containername

&nbsp;
