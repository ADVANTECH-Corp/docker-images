FROM ubuntu:16.04

MAINTAINER Advantech

# update
RUN apt-get update
RUN apt-get install -y apt-utils sudo vim ftp
RUN apt-get install -y locales curl cpio git build-essential python diffstat texinfo gawk chrpath dos2unix wget unzip socat doxygen lib32stdc++6 lib32z1 lib32ncurses5 libc6-dev-i386 gcc-multilib g++-multilib

# jenkins
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# openjdk
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk
# crc32
RUN apt-get install -y libarchive-zip-perl

# make /bin/sh symlink to bash instead of dash:
# To set this particular option to false:
RUN echo "dash dash/sh boolean false" | debconf-set-selections
# and to actually reconfigure the package:
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

# adv account (password: adv)
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
RUN mkdir -p ${HOME}/bin \
	&& git clone https://gerrit-googlesource.lug.ustc.edu.cn/git-repo \
	&& cp git-repo/repo ${HOME}/bin \
	&& chmod a+x ${HOME}/bin/repo \
	&& mkdir -p ${HOME}/bin/.repo \
	&& mv git-repo ${HOME}/bin/.repo/repo
ENV PATH="/home/adv/bin:${PATH}"

RUN wget https://releases.linaro.org/components/toolchain/binaries/7.2-2017.11/arm-linux-gnueabihf/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabihf.tar.xz
RUN tar -Jxvf gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabihf.tar.xz -C $HOME
RUN rm gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabihf.tar.xz
RUN wget https://releases.linaro.org/components/toolchain/binaries/7.2-2017.11/aarch64-linux-gnu/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu.tar.xz
RUN tar -Jxvf gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu.tar.xz -C $HOME
RUN rm gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu.tar.xz

ENV TOOLCHAIN_PATH_ARMV7=/home/adv/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabihf
ENV TOOLCHAIN_PATH_ARMV8=/home/adv/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu

# locale
RUN sudo locale-gen en_US.UTF-8
RUN sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG="en_US.UTF-8"

RUN sudo mkdir -p /adv \
	&& sudo chown adv:adv -R /adv
WORKDIR /adv

