#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Utility script that stitches the tags and release script together
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Plumbing package versions into normalised format"
VERSION=$(${SCRIPTDIR}/normalize-versions.sh)

echo "Detecting tags"
TAGS=$(${SCRIPTDIR}/detect-tags.sh)

echo "Building docker image for version ${VERSION} and tagging as ${TAGS[@]}"

${SCRIPTDIR}/build-and-push.sh ${VERSION} ${TAGS}
