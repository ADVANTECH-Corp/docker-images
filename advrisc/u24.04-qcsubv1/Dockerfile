FROM ubuntu:24.04

LABEL org.opencontainers.image.authors="Advantech"

RUN userdel -r ubuntu

ARG UNAME=adv

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color

# update
RUN apt update && \
    apt install -y \
        git \
        sudo \
        subversion

# timezone
RUN DEBIAN_FRONTEND=noninteractive apt install -y tzdata
ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

# zstd
RUN apt-get install -y zstd

# tools
RUN apt-get install -y vim repo

# Ubuntu kernel
RUN sed -i '/Types: deb/{N;s/Types: deb\nURIs: http:\/\/archive\.ubuntu\.com\/ubuntu/Types: deb deb-src\nURIs: http:\/\/archive\.ubuntu\.com\/ubuntu/}' /etc/apt/sources.list.d/ubuntu.sources
RUN apt update && \
    apt build-dep -y linux; \
    apt install -y \
        fakeroot llvm libncurses-dev dwarves dwarfdump \
        gcc-aarch64-linux-gnu \
        devscripts \
        qemu-user-static mtools dosfstools

# locale
RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG="en_US.UTF-8"

# Create account
RUN useradd -m -k /home/${UNAME} ${UNAME} -p ajLGz61mdCP76 -s /bin/bash -G sudo

# set up as sudo
RUN echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
WORKDIR /home/${UNAME}
USER ${UNAME}
ENV USER=${UNAME}
