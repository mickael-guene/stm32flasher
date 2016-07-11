#!/bin/bash

apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    build-essential git libtool pkg-config autoconf libusb-1.0 automake

env GIT_SSL_NO_VERIFY=true git clone -b v0.9.0 https://github.com/ntfreak/openocd.git

cd openocd && ./bootstrap && ./configure && make -j8 && make install

rm -Rf /openocd

apt-get remove -y build-essential git libtool pkg-config autoconf automake
apt-get autoremove -y

rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
