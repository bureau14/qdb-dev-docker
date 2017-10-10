FROM       ubuntu:xenial

ARG        QDB_VERSION=2.1.0master
ENV        QDB_DEB_VERSION=1
ENV        TERM=dumb

RUN        apt-get update
RUN        apt-get install -y wget locales
RUN        apt-get install -y python-setuptools php-pear php-dev libpcre3-dev
RUN        ln -s -f /bin/true /usr/bin/chfn

# Install core dependencies
COPY       qdb-server_${QDB_VERSION}-${QDB_DEB_VERSION}.deb .
COPY       qdb-web-bridge_${QDB_VERSION}-${QDB_DEB_VERSION}.deb .
COPY       qdb-utils_${QDB_VERSION}-${QDB_DEB_VERSION}.deb .
COPY       qdb-api_${QDB_VERSION}-${QDB_DEB_VERSION}.deb .
RUN        dpkg -i qdb-server_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
RUN        dpkg -i qdb-web-bridge_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
RUN        dpkg -i qdb-utils_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
RUN        dpkg -i qdb-api_${QDB_VERSION}-${QDB_DEB_VERSION}.deb

# PHP
COPY       quasardb-${QDB_VERSION}.tgz .
RUN        pecl install quasardb-${QDB_VERSION}.tgz

# Python
COPY       quasardb-${QDB_VERSION}-py2.7-linux-x86_64.egg .
RUN        easy_install quasardb-${QDB_VERSION}-py2.7-linux-x86_64.egg

# Set the locale
RUN        locale-gen en_US.UTF-8
ENV        LANG en_US.UTF-8
ENV        LANGUAGE en_US:en
ENV        LC_ALL en_US.UTF-8

ADD        qdb-dev-docker-wrapper.sh /usr/sbin/

# Define mountable directory
VOLUME     ["/var/lib/qdb/db"]

# Define working directory
WORKDIR    /var/lib/qdb

# Always launch qdb process
ENTRYPOINT ["/usr/sbin/qdb-dev-docker-wrapper.sh"]

# Expose the port qdbd is listening at
EXPOSE     2836
