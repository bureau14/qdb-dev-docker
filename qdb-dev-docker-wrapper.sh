#!/usr/bin/env sh

QDB_SERVER=`which qdbd`
QDB_HTTPD_SERVER=`which qdb_httpd`


# Detects the presence of a license file, and provides it as an
# argument to `qdbd` if found.
POTENTIAL_LICENSE_FILE="/var/lib/qdb/license.txt"
LICENSE_FILE_PARAMETER=""

if [ -f ${POTENTIAL_LICENSE_FILE} ]; then
    echo "license file found! ${POTENTIAL_LICENSE_FILE}"
    LICENSE_FILE_PARAMETER="--license-file ${POTENTIAL_LICENSE_FILE}"
fi

${QDB_HTTPD_SERVER} -d
${QDB_SERVER} ${LICENSE_FILE_PARAMETER} -d

echo "Thank you for trying quasardb!"
echo "You can now run qdbsh or work in python."
echo " "
echo "***WARNING*** Exiting the shell will stop the container"

/bin/bash -i
