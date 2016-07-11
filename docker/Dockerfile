FROM ubuntu:14.04
MAINTAINER Mickael Guene <mickael.guene@st.com>

ENV http_proxy http://10.129.186.101:3128
ENV https_proxy http://10.129.186.101:3128

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    build-essential git libtool pkg-config autoconf libusb-1.0 automake

RUN env GIT_SSL_NO_VERIFY=true git clone -b v0.9.0 https://github.com/ntfreak/openocd.git

RUN cd openocd && ./bootstrap && ./configure && make -j8 && make install

RUN rm -Rf openocd

CMD ["/usr/local/bin/openocd", "-v"]
