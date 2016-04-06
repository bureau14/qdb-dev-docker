FROM       ubuntu:latest

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# User configurable: define versions we are using
ENV        QDB_VERSION     2.0.0
ENV        QDB_DEB_VERSION 1
ENV        QDB_URL         http://download.quasardb.net/quasardb/2.0/2.0.0rc5/server/qdb-server_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
ENV        QDB_HTTPD_URL   http://download.quasardb.net/quasardb/2.0/2.0.0rc5/web-bridge/qdb-web-bridge_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
ENV        QDB_UTILS_URL   http://download.quasardb.net/quasardb/2.0/2.0.0rc5/utils/qdb-utils_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
ENV        QDB_CAPI_URL    http://download.quasardb.net/quasardb/2.0/2.0.0rc5/api/c/qdb-api_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
ENV        QDB_PHPAPI_URL  http://download.quasardb.net/quasardb/2.0/2.0.0rc5/api/php/quasardb-2.0.0.tgz
ENV        QDB_PYAPI_URL   http://download.quasardb.net/quasardb/2.0/2.0.0rc5/api/python/qdb_python_api-2.0.0rc5-py2.7-linux-x86_64.egg

#############################
# NO EDITING BELOW THIS LINE
#############################

RUN        apt-get update
RUN        apt-get install -y wget
RUN        apt-get -y install python-setuptools php-pear php5-dev libpcre3-dev
RUN        wget ${QDB_URL}
RUN        wget ${QDB_HTTPD_URL}
RUN        wget ${QDB_UTILS_URL}
RUN        wget ${QDB_CAPI_URL}
RUN        wget ${QDB_PHPAPI_URL}
RUN        wget ${QDB_PYAPI_URL}
RUN        ln -s -f /bin/true /usr/bin/chfn
RUN        dpkg -i qdb-server_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
RUN        dpkg -i qdb-web-bridge_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
RUN        dpkg -i qdb-utils_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
RUN        dpkg -i qdb-api_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
RUN        easy_install *.egg
RUN        pecl install quasardb*.tgz
RUN        echo "extension=quasardb.so" > /etc/php5/cli/conf.d/quasardb.ini

ADD        qdb-dev-docker-wrapper.sh /usr/sbin/

# Define mountable directory
VOLUME     ["/var/lib/qdb/db"]

# Define working directory
WORKDIR    /var/lib/qdb

# Always launch qdb process
ENTRYPOINT ["/usr/sbin/qdb-dev-docker-wrapper.sh"]

# Expose the port qdbd is listening at
EXPOSE     2836
