## QuasarDB Python test development Dockerfile

This repository contains the **Dockerfile** of [QuasarDB](http://www.quasardb.net/) development evaluation toolkit published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

It contains:

 * A quasardb daemon
 * A quasardb shell
 * quasardb http monitoring service
 * Python API
 * Ipython notebook server

It is not **meant for production use**.

### Supported tags

|tag|description|
|---|---|
|`latest`|latest stable release|
|`beta`|latest beta release|
|`nightly`|bleeding edge|

### Base Docker Image

* [dockerfile/ubuntu](http://dockerfile.github.io/#/ubuntu)

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/bureau14/qdb-python/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull bureau14/qdb-dev`

   (alternatively, you can build an image from Dockerfile: `docker build -t="qdb-python" github.com/bureau14/qdb-dev-docker/python`)


### Usage

  Initial start
  docker run -it -p 8081:8081 -p 2836:2836 -p 8080:8080   --mount source=quasardb,target=/var/lib/qdb/db  --name qdb-python bureau14/qdb-python

  Exiting the shell will stop the container.

  Then docker run -it start qdb-python to restart if exited
  Data in the DB is persisted on Docker host in Docker volume quasardb
