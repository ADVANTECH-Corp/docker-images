FROM ubuntu:22.04

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

#android packages

RUN apt-get install -y gawk wget git-core diffstat unzip
RUN apt-get install -y texinfo gcc-multilib g++-multilib
Run apt-get install -y python2-minimal python2 dh-python python-is-python3
RUN apt-get install -y build-essential chrpath socat cpio python3 python3-pip
RUN apt-get install -y python3-pexpect bc device-tree-compiler
RUN apt-get install -y xz-utils debianutils iputils-ping python3-git python3-jinja2
RUN apt-get install -y libegl1-mesa libsdl1.2-dev
RUN apt-get install -y xterm rsync curl zstd lz4 libssl-dev

RUN apt-get install -y openjdk-11-jdk
RUN apt-get install -y gnupg flex bison gperf zip x11proto-core-dev ccache adb fastboot xsltproc
RUN apt-get install -y lib32z-dev libgl1-mesa-dev libxml2-utils libx11-dev lib32ncurses5-dev libc6-dev-i386 zlib1g-dev

RUN apt-get install -y libelf-dev
RUN apt-get install -y dwarves
RUN apt-get install -y libncurses5

# jenkins
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN apt-get update


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
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > ${HOME}/bin/repo
RUN chmod a+x ${HOME}/bin/repo
ENV PATH="/home/adv/bin:${PATH}"


ENV USER adv

# locale
RUN sudo apt-get install -y locales
RUN sudo locale-gen en_US.UTF-8
RUN sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG="en_US.UTF-8"

