FROM ubuntu:14.04
MAINTAINER Mickael Guene <mickael.guene@st.com>

ENV http_proxy http://10.129.186.101:3128
ENV https_proxy http://10.129.186.101:3128

COPY run.sh /run.sh

RUN /run.sh

CMD ["/usr/local/bin/openocd", "-v"]
