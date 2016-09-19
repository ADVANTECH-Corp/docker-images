FROM ubuntu:14.04

MAINTAINER Advantech

# yocto
RUN apt-get update
RUN apt-get install -y gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm
RUN apt-get install -y autoconf automake libtool libglib2.0-dev libarchive-dev

# 96Boards specific
RUN apt-get install -y git whiptail curl

# tools
RUN apt-get install -y vim
RUN apt-get install -y sudo

# adv account
RUN useradd -m -k /home/adv adv -p adv -s /bin/bash -G sudo

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
