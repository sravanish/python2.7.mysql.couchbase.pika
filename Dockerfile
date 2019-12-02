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
  apt-get install -y vim wget curl bash-completion && \
  apt-get install -y libcurl4-openssl-dev libssl-dev


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

# Clean potential old libraries
RUN \
  apt -y install python-pycurl

# Install additional packages
RUN pip install mysql-connector-python-rf requests paramiko scp dateutils pycurl pika netaddr

# Install couchbase dev tools
RUN wget http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-4-amd64.deb && \ 
  dpkg -i couchbase-release-1.0-4-amd64.deb && \
  apt-get update && \
  apt-get -y install libcouchbase-dev build-essential && \
  pip install couchbase openpyxl && \
  rm couchbase-release-1.0-4-amd64.deb && \
  rm -rf /var/lib/apt/lists/*


CMD ["python"]
