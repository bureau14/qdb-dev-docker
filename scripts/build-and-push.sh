#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ -z "$2" ]
then
    echo "Usage: build-and-push.sh version [tag & tags..]"
    exit 1
fi

VERSION=$1

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE="bureau14/qdb-dev"

docker build  -t ${IMAGE}:build --build-arg QDB_VERSION=${VERSION} ${SCRIPTDIR}/..

shift
for TAG in "$@"
do
    docker tag ${IMAGE}:build ${IMAGE}:$TAG
    docker push ${IMAGE}:$TAG
done
