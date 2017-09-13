FROM       ubuntu:latest

RUN apt-get clean && apt-get update \
&& apt-get install -y locales net-tools iproute2 vim wget

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get install -y python2.7
RUN apt-get install -y python-matplotlib
RUN apt-get install -y ipython
RUN apt-get install -y ipython-notebook
RUN apt-get install -y python-pandas
RUN apt-get -y install python-setuptools

# User configurable: define versions we are using
ENV        QDB_VERSION     2.1.0
ENV        QDB_DEB_VERSION 1
ENV        QDB_URL         http://download.quasardb.net/quasardb/2.1/2.1.0-beta.2/server/qdb-server_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
ENV        QDB_HTTPD_URL   http://download.quasardb.net/quasardb/2.1/2.1.0-beta.2/web-bridge/qdb-web-bridge_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
ENV        QDB_UTILS_URL   http://download.quasardb.net/quasardb/2.1/2.1.0-beta.2/utils/qdb-utils_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
ENV        QDB_CAPI_URL    http://download.quasardb.net/quasardb/2.1/2.1.0-beta.2/api/c/qdb-api_${QDB_VERSION}-${QDB_DEB_VERSION}.deb
ENV        QDB_PHPAPI_URL  http://download.quasardb.net/quasardb/2.1/2.1.0-beta.2/api/php/quasardb-2.1.0.tgz
ENV        QDB_PYAPI_URL   http://download.quasardb.net/quasardb/2.1/2.1.0-beta.2/api/python/quasardb-2.1.0b2-py2.7-linux-x86_64.egg

#############################
# NO EDITING BELOW THIS LINE
#############################


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

# Define working directory
WORKDIR    /var/lib/qdb

ADD        qdb-dev-docker-wrapper.sh /usr/sbin/
ADD        qdb.ipynb /var/lib/qdb/


# Always launch qdb process
ENTRYPOINT ["/usr/sbin/qdb-dev-docker-wrapper.sh"]

# Expose the port qdbd is listening at
EXPOSE     2836
EXPOSE     8080
EXPOSE     8081
