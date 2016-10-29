FROM openrovdocker/armhf-buildtools
MAINTAINER spiderkeys

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        libssl-dev \
        libz-dev && \
    apt-get autoremove -y && \
    apt-get clean

RUN wget http://openrov-software-nightlies.s3-us-west-2.amazonaws.com/jessie/libuv-static/libuv-static-531f06e-latest_1.0.0_armhf.deb
RUN dpkg -i libuv-static-531f06e-latest_1.0.0_armhf.deb
RUN rm libuv-static-531f06e-latest_1.0.0_armhf.deb