# This Dockerfile will set up an development environment that can be used
# to develop or troubleshoot the tyco-mesh python app.
# Based on Ubuntu Xenial Xerus.
#

FROM ubuntu:16.04

#Set root password
RUN echo root:docker | chpasswd

# === Install debian development packages =====================================

RUN apt-get update && apt-get install -y \
    apt-utils

# Development essentials
RUN apt-get install -y \
  autoconf \
  automake \
  build-essential \
  libtool

# Fetching, dling
RUN apt-get install -y \
  git-core \
  wget

# Troubleshooting
RUN apt-get install -y \
  vim

# === Install tyco-mesh depencies, or required to build other dependencies. ===

# These packages are used for the tyco-mesh messaging layer.
RUN apt-get install -y \
  libsqlite3-dev \
  pkg-config \
  python \
  python-dev \
  python-zmq

# Need gtk-doc-tools to make libnice's build system happy.
# Need gstreamer tools and libgstreamer-dev to build libnice.
# Need python-gi-dev for gobject-introspection
# Need a libcurl development package for the custom version of pycurl to build.
RUN apt-get install -y \
  gtk-doc-tools \
  gstreamer1.0-tools \
  libgstreamer1.0-dev \
  libgirepository1.0-dev \
  python-gi-dev \
  libssl-dev

# Need avconv for generating h264 files.
RUN apt-get install -y \
  libav-tools

WORKDIR /root

# === Install pip =============================================================

# Let's go get pip and easy_install
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN rm get-pip.py

# === Retrieve source code ====================================================

# Any pacakges being installed in the following sections are unavailable as
# standard debian packages, typically because they're too new or have been
# updated/modified to support tyco-mesh.

# Some of the programs that we're using to retrieve source (git) are dependent
# on packages we're customizing (libcurl).  We're trying to make a point of
# making sure we're buiding against the right version of everything, so we're
# going to retrieve all the source, dump the git/libcurl dependency, and then
# perform build/installs.

# TODO: instead of cloning from branch names, clone from specific git commits.
RUN mkdir -p libnice
COPY . ./libnice/
WORKDIR ./libnice
RUN ./autogen.sh --prefix=/usr --with-gstreamer --enable-symbols
RUN make V=1 -j 1>good.txt 2>bad.txt
##RUN make -j && make install && ldconfig
##RUN ldconfig
##WORKDIR /root
##RUN rm -rf /root/libnice
##
