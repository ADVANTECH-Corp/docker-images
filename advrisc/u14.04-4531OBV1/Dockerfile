FROM ubuntu:14.04

MAINTAINER Advantech

# openwrt
RUN apt-get update
RUN apt-get install -y gcc g++ binutils patch autoconf libcurl4-openssl-dev bzip2 flex make gettext pkg-config unzip zlib1g-dev libc6-dev subversion git libncurses5-dev gawk sharutils curl libxml-parser-perl python-yaml ocaml-nox ocaml ocaml-findlib libssl-dev

RUN apt-get install -y bsdmainutils

# tools
RUN apt-get install -y vim
RUN apt-get install -y sudo
RUN apt-get install -y ftp
RUN apt-get install -y subversion

# jenkins
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN apt-get install -y openjdk-7-jdk

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
RUN git config --global credential.helper 'store --file ~/.my-credentials'

# repo
RUN mkdir -p ${HOME}/bin
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > ${HOME}/bin/repo
RUN chmod a+x ${HOME}/bin/repo
ENV PATH="/home/adv/bin:${PATH}"

# locale
RUN sudo locale-gen en_US.UTF-8
RUN sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG="en_US.UTF-8"
