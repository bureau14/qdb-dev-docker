#!/usr/bin/env sh
IP=`which ip`
AWK=`which awk`
QDB_SERVER=`which qdbd`
QDB_HTTPD_SERVER=`which qdb_httpd`
PORT=2836

# Find internal IP of docker container
IP=`${IP} route get 8.8.8.8 | ${AWK} 'NR==1 {print $NF}'`

# Detects the presence of a license file, and provides it as an
# argument to `qdbd` if found.
POTENTIAL_LICENSE_FILE="/var/lib/qdb/license.txt"
LICENSE_FILE_PARAMETER=""

if [ -f ${POTENTIAL_LICENSE_FILE} ]; then
    echo "license file found! ${POTENTIAL_LICENSE_FILE}"
    LICENSE_FILE_PARAMETER="--license-file ${POTENTIAL_LICENSE_FILE}"
fi

#start QDB server
${QDB_SERVER} ${LICENSE_FILE_PARAMETER} --security=false -a ${IP}:${PORT} &

#configure http monitoring with
qdb_httpd --gen-config | sed s/127.0.0.1:8080/"$IP":8080/ \
| sed s/127.0.0.1:2836/"$IP":2836/ | sed s:/var/lib/share/qdb/www:/usr/share/qdb/www: > /var/lib/qdb/qdb_httpd_default_config.conf


${QDB_HTTPD_SERVER}  -c /var/lib/qdb/qdb_httpd_default_config.conf &

#start python notebook
ipython notebook --ip=* --port=8081 &

echo "Thank you for trying quasardb!"
echo "You can now run qdbsh or work in python notebook on port 8081."
echo "In the connect string in notebook use qdb://${IP}:${PORT}"
echo " "
echo "***WARNING*** Exiting the shell will stop the container"


/bin/bash -i
