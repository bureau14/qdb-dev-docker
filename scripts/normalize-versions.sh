#!/usr/bin/env bash
##
# Script that does some plumbing to align all package versions
# into a consistent format so it's easier for the Dockerfile
# to deal with.
#
# This script returns the actual probed version.

set -euo pipefail
IFS=$'\n\t'

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

##
# Probe version based on server deb.
readarray -t SERVER_FILES <<<`ls ${SCRIPTDIR}/../qdb-server_*-1.deb`
if [ "${#SERVER_FILES[@]}" -ne "1" ]
then
    echo "Needs exactly 1 server deb in the format of 'qdb-server_*-1.deb'"
    exit 1
fi
SERVER_FILE=$(basename ${SERVER_FILES[0]})
VERSION=-

if [[ ${SERVER_FILE} =~ (qdb-server_(.+)-1.deb$) ]]
then
    VERSION=${BASH_REMATCH[2]}
else
    echo "Server deb does not match expected format: ${SERVER_FILE}"
    exit 1
fi

##
# Normalze PHP package
mv ${SCRIPTDIR}/../quasardb-*.tgz ${SCRIPTDIR}/../quasardb-${VERSION}.tgz

##
# Normalize Python package
mv ${SCRIPTDIR}/../quasardb-*-py2.7-linux-x86_64.egg ${SCRIPTDIR}/../quasardb-${VERSION}-py2.7-linux-x86_64.egg

echo ${VERSION}
