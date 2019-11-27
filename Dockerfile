FROM ubuntu:16.04

# Setup environment
ENV DEBIAN_FRONTEND noninteractive

# Install common
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y vim wget curl bash-completion


# Install python 2.7 
RUN \
  add-apt-repository ppa:jonathonf/python-2.7 && \
  apt-get update && \
  apt-get install -y python2.7 python2.7-dev && \
  rm -f /usr/bin/python && ln -s /usr/bin/python2.7 /usr/bin/python

# Install python pip
RUN wget https://bootstrap.pypa.io/get-pip.py && \
  python get-pip.py && \
  rm -f /usr/bin/pip && ln -s /usr/local/bin/pip /usr/bin/pip && \
  rm get-pip.py
  
# Install mysql connector and requests modules for python
RUN pip install mysql-connector-python-rf requests

# Install paramiko for scp
RUN pip install paramiko scp

# Install pika for rabbitmq
RUN pip install pika

# Install dateutils
RUN pip install dateutils

# Install netaddr
RUN pip install netaddr

# Install pycurl
RUN \
  apt-get update && \
  apt-get install -y libcurl4-gnutls-dev && \
  apt-get install -y python-pycurl

# Install couchbase dev tools
RUN wget http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-4-amd64.deb && \ 
  dpkg -i couchbase-release-1.0-4-amd64.deb && \
  apt-get update && \
  apt-get -y install libcouchbase-dev build-essential && \
  pip install couchbase openpyxl && \
  rm couchbase-release-1.0-4-amd64.deb && \
  rm -rf /var/lib/apt/lists/*


CMD ["python"]

