FROM ubuntu:20.04

MAINTAINER Advantech

ENV DEBIAN_FRONTEND=noninteractive

# update
RUN apt-get update

RUN apt-get install -y git
RUN apt-get install -y subversion

#timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

#NXP packages

RUN apt-get install -y gawk wget git-core diffstat unzip
RUN apt-get install -y texinfo gcc-multilib
RUN apt-get install -y build-essential chrpath socat cpio python python3 python3-pip
RUN apt-get install -y python3-pexpect
RUN apt-get install -y xz-utils debianutils iputils-ping python3-git python3-jinja2
RUN apt-get install -y libegl1-mesa libsdl1.2-dev
RUN apt-get install -y pylint3 xterm rsync curl zstd lz4 libssl-dev

RUN apt-get install -y curl scons sqlite3 libsqlite3-dev diffstat xmlstarlet texinfo chrpath gcc-aarch64-linux-gnu libarchive-dev ssh libselinux1-dev fakechroot g++-aarch64-linux-gnu libiberty-dev qemu-user-static g++ gawk gcc make libwayland-dev fakeroot libpam0g-dev openjdk-8-jdk-headless binutils-dev util-linux uuid-dev zstd libncurses5 libxml2-utils libxml-simple-perl python3-pip whiptail cpio lib32stdc++6

RUN pip3 install pyyaml

RUN rm -rf /lib/ld-linux-aarch64.so.1
RUN ln -sf  /usr/aarch64-linux-gnu/lib/ld-2.31.so /lib/ld-linux-aarch64.so.1
RUN ln -sf /bin/bash /bin/sh
RUN wget http://archive.ubuntu.com/ubuntu/pool/universe/q/qemu/qemu-user-static_6.2+dfsg-2ubuntu6_amd64.deb
RUN dpkg -i qemu-user-static_6.2+dfsg-2ubuntu6_amd64.deb

# zstd
RUN apt-get install -y zstd

# crc32
RUN apt-get install -y libarchive-zip-perl

# tools
RUN apt-get install -y vim
RUN apt-get install -y sudo
RUN apt-get install -y ftp

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
RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ${HOME}/bin/repo
RUN chmod a+x ${HOME}/bin/repo
ENV PATH="/home/adv/bin:${PATH}"


ENV USER adv

# locale
RUN sudo apt-get install -y locales
RUN sudo locale-gen en_US.UTF-8
RUN sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG="en_US.UTF-8"
