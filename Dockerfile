# get base ubuntu image
# I like ubuntu, easy to get packages
FROM ubuntu:20.04

# update repos and install required packages
RUN chsh -s /usr/bin/bash \
    && echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt-get install -y -q \
    && chmod 777 /var/cache/debconf/ \
    && chmod 777 /var/cache/debconf/passwords.dat \
    && apt-get update \
    && apt-get install apt-utils dialog -y \
    && apt-get upgrade -y \
    && echo "apt-get install linux-image-$(uname -r) -y" \
    && apt-get autoremove -y

RUN packages="build-essential git tcl-dev libpcap0.8-dev python" \
    && for i in $packages; do apt-get install --ignore-missing -y "$i"; done

# clone and install dpdk
WORKDIR /root
RUN git clone https://github.com/PatrickKutch/hping.git \
    && ln -s /usr/include/pcap/bpf.h /usr/include/net/bpf.h

WORKDIR /root/hping
RUN ./configure \
    && make \
    && make install

ENTRYPOINT ["hping3"]
