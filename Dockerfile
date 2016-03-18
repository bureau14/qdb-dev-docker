FROM       ubuntu:latest

# User configurable: define versions we are using
ENV        QDB_VERSION     2.0.0
ENV        QDB_DEB_VERSION 1
ENV        QDB_URL         http://download.quasardb.net/quasardb/2.0/2.0.0rc4/server/qdb-server_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
ENV        QDB_UTILS_URL   http://download.quasardb.net/quasardb/2.0/2.0.0rc4/utils/qdb-utils_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
ENV        QDB_CAPI_URL    http://download.quasardb.net/quasardb/2.0/2.0.0rc4/api/c/qdb-api_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
ENV        QDB_PHPAPI_URL  http://download.quasardb.net/quasardb/2.0/2.0.0rc4/api/php/quasardb-2.0.0.tgz
ENV        QDB_PYAPI_URL   http://download.quasardb.net/quasardb/2.0/2.0.0rc4/api/python/qdb_python_api-2.0.0rc2-py2.7-linux-x86_64.egg
#ENV        QDB_JAVAAPI_URL http://download.quasardb.net/quasardb/2.0/2.0.0rc4/api/java/qdb-api-java-linux-2.0.0.jar

#############################
# NO EDITING BELOW THIS LINE
#############################

RUN        apt-get update
RUN        apt-get install -y wget
RUN        apt-get -y install python-setuptools php-pear php5-dev libpcre3-dev
RUN        wget ${QDB_URL}
RUN        wget ${QDB_UTILS_URL}
RUN        wget ${QDB_CAPI_URL}
RUN        wget ${QDB_PHPAPI_URL}
RUN        wget ${QDB_PYAPI_URL}
#RUN        wget ${QDB_JAVAAPI_URL}
RUN        ln -s -f /bin/true /usr/bin/chfn
RUN        dpkg -i qdb-server_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
RUN        dpkg -i qdb-utils_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
RUN        dpkg -i qdb-api_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
RUN        easy_install *.egg
RUN        pecl install quasardb*.tgz
RUN        echo "extension=quasardb.so" > /etc/php5/cli/conf.d/quasardb.ini

ADD        qdbd-docker-wrapper.sh /usr/sbin/

# Define mountable directory
VOLUME     ["/var/lib/qdb/db"]

# Define working directory
WORKDIR    /var/lib/qdb

# Always launch qdb process
ENTRYPOINT ["/usr/sbin/qdbd-docker-wrapper.sh"]

# Expose the port qdbd is listening at
EXPOSE     2836
