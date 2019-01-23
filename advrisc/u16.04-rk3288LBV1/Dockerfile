FROM ubuntu:16.04

MAINTAINER jinmin.xu@advantench.com.cn

# update
RUN apt-get update

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
RUN apt-get install -y vim
RUN apt-get install -y sudo
RUN apt-get install -y ftp

# base
RUN apt-get install -y apt-utils  --assume-yes
RUN apt-get install -y git-core curl
ENV DEBIAN_FRONTEND noninteractive

# networking
RUN apt-get install -y net-tools

# locale
RUN apt-get install -y locales && \
locale-gen en_US.UTF-8 && \
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG="en_US.UTF-8"


# set rk3288 sdk environment
RUN apt-get install -y git gcc-arm-linux-gnueabihf u-boot-tools device-tree-compiler mtools \
parted libudev-dev libusb-1.0-0-dev python-linaro-image-tools linaro-image-tools libssl-dev \
autotools-dev libsigsegv2 m4 libdrm-dev curl sed make binutils build-essential gcc g++ bash \
patch gzip bzip2 perl tar cpio python unzip rsync file bc wget libncurses5 libglib2.0-dev \
openssh-client time

# set rk3288 debian rootfs environment
RUN apt-get install -y  binfmt-support qemu-user-static live-build


#fix error environment for build
RUN apt-get install -y gcc-multilib && \
wget http://launchpadlibrarian.net/109052632/python-support_1.0.15_all.deb && \
dpkg -i python-support_1.0.15_all.deb

# adv account
#RUN useradd -m -k /home/adv adv -p adv -s /bin/bash -G sudo
RUN useradd -m -k /home/adv adv -p ajLGz61mdCP76 -s /bin/bash -G sudo

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

