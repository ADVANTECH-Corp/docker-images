FROM ubuntu:14.04

MAINTAINER Advantech

# update
RUN apt-get update

# from freescale user guide
RUN apt-get install -y uuid uuid-dev
RUN apt-get install -y zlib1g-dev liblz-dev
RUN apt-get install -y liblzo2-2 liblzo2-dev
RUN apt-get install -y lzop
RUN apt-get install -y git-core curl
RUN apt-get install -y u-boot-tools
RUN apt-get install -y mtd-utils
RUN apt-get install -y android-tools-fsutils

# Installing required packages (Ubuntu 14.04) in  android
RUN apt-get install -y git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev
RUN apt-get install -y libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip

#ubuntu 14.04 need to install be when build fail
RUN apt-get install -y bc

# openjdk
RUN apt-get install -y openjdk-7-jdk

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