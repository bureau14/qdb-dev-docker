## QuasarDB test development Dockerfile

This repository contains the **Dockerfile** of [QuasarDB](http://www.quasardb.net/) development evaluation toolkit published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

It contains:

 * A quasardb daemon
 * A quasardb shell
 * C API
 * Python API

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

2. Download [automated build](https://registry.hub.docker.com/u/bureau14/qdb-dev/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull bureau14/qdb-dev`

   (alternatively, you can build an image from Dockerfile: `docker build -t="qdb-dev" github.com/bureau14/qdb-dev-docker`)


### Usage

    docker run -i --name qdb-dev bureau14/qdb-dev