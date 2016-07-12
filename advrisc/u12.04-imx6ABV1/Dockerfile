FROM ubuntu:12.04

MAINTAINER Advantech

RUN apt-get update

# from freescale user guide
RUN apt-get install -y uuid uuid-dev
RUN apt-get install -y zlib1g-dev liblz-dev
RUN apt-get install -y liblzo2-2 liblzo2-dev
RUN apt-get update
RUN apt-get install -y git-core curl
RUN apt-get install -y u-boot-tools
RUN apt-get install -y uboot-mkimage

#RUN apt-get update

RUN apt-get install -y git gnupg flex bison gperf
RUN apt-get install -y libc6-dev
RUN apt-get install -y build-essential zip curl libc6-dev libncurses5-dev:i386 x11proto-core-dev
RUN apt-get install -y libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-glx:i386 libgl1-mesa-dev g++-multilib mingw32
RUN apt-get install -y tofrodos python-markdown libxml2-utils xsltproc zlib1g-dev:i386

#Android 4.2
RUN apt-get install -y liblzo2-dev:i386 uuid-dev:i386
RUN ln -sf /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/libGL.so

#java
RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties

RUN echo oracle-java6-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections

RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN apt-get install -y oracle-java6-installer
RUN apt-get install -y oracle-java6-set-default


# crc32
RUN apt-get install -y libarchive-zip-perl

# tools
RUN apt-get install -y vim
RUN apt-get install -y sudo

# networking
#RUN apt-get install -y ping net-tools

# adv account
RUN useradd -m -k /home/adv adv -p adv -s /bin/bash -G sudo

# set up adv as sudo
RUN echo "adv ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
WORKDIR /home/adv
USER adv
