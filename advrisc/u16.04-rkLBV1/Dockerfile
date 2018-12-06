FROM ubuntu:16.04

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

#RUN apt-get update

#RUN apt-get install -y python2.7
#RUN apt-get install -y python-pip
#RUN apt-get install -y python2.7-dev

#RUN apt-get install -y libssl1.0.0 libssl-dev

RUN apt-get update
RUN apt-get install -y locales
RUN apt-get install -y repo
RUN apt-get install -y git-core
RUN apt-get install -y gitk
RUN apt-get install -y git-gui
RUN apt-get install -y gcc-arm-linux-gnueabihf
RUN apt-get install -y u-boot-tools
RUN apt-get install -y device-tree-compiler
RUN apt-get install -y gcc-aarch64-linux-gnu
RUN apt-get install -y mtools
RUN apt-get install -y parted

#--------------------------------
RUN apt-get install -y libc6-dev-i386
RUN apt-get install -y lib32ncurses5-dev
RUN apt-get install -y x11proto-core-dev
#--------------------------------

RUN apt-get install -y libudev-dev
RUN apt-get install -y libusb-1.0-0-dev
RUN apt-get install -y python-linaro-image-tools linaro-image-tools gcc-4.8-multilib-arm-linux-gnueabihf
RUN apt-get install -y gcc-arm-linux-gnueabihf
RUN apt-get install -y libssl-dev gcc-aarch64-linux-gnu
RUN apt-get install -y autoconf autotools-dev
RUN apt-get install -y libsigsegv2 m4 intltool libdrm-dev sed make binutils build-essential gcc g++ bash patch gzip
RUN apt-get install -y bzip2 perl tar cpio python unzip rsync file bc wget libncurses5 libqt4-dev libglib2.0-dev libgtk2.0-dev
RUN apt-get install -y libglade2-dev cvs git mercurial rsync openssh-client subversion asciidoc w3m dblatex
RUN apt-get install -y graphviz python-matplotlib
RUN apt-get install -y libssl-dev texinfo liblz4-tool genext2fs time

# jenkins
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN apt-get update

# openjdk
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk
# crc32
RUN apt-get install -y libarchive-zip-perl

# tools
#RUN apt-get update
#RUN apt-get install -y locales
RUN apt-get install -y vim
RUN apt-get install -y sudo
RUN apt-get install -y ftp

#For RK debian linaro rootfs
#RUN apt-get install -y libpsl5

#debian
RUN wget http://launchpadlibrarian.net/109052632/python-support_1.0.15_all.deb
RUN dpkg -i python-support_1.0.15_all.deb
RUN apt-get update
RUN apt-get install -y linaro-image-tools


# networking
#RUN apt-get install -y ping net-tools

# adv account
#RUN useradd -m -k /home/adv adv -p adv -s /bin/bash -G sudo
RUN useradd -m -k /home/adv adv -p ajLGz61mdCP76 -s /bin/bash -G sudo
RUN chmod +s /usr/sbin/sshd

# set up adv as sudo
RUN echo "adv ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
WORKDIR /home/adv
USER adv

# git config
RUN git config --global user.email "you@example.com"
RUN git config --global user.name "Your Name"
RUN git config --global color.ui "auto"

# repo
RUN mkdir -p ${HOME}/bin
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > ${HOME}/bin/repo
RUN chmod a+x ${HOME}/bin/repo
ENV PATH="/home/adv/bin:${PATH}"


ENV USER adv

# locale
RUN sudo locale-gen en_US.UTF-8
RUN sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG="en_US.UTF-8"


