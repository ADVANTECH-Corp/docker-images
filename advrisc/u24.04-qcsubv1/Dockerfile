FROM ubuntu:24.04

LABEL org.opencontainers.image.authors="Advantech"

RUN userdel -r ubuntu

ENV TERM=xterm-256color

# Ubuntu kernel
RUN sed -i '/Types: deb/{N;s/Types: deb\nURIs: http:\/\/archive\.ubuntu\.com\/ubuntu/Types: deb deb-src\nURIs: http:\/\/archive\.ubuntu\.com\/ubuntu/}' /etc/apt/sources.list.d/ubuntu.sources

RUN apt-get update; \
    apt-get build-dep -y linux; \
    apt-get install -y \
        fakeroot llvm libncurses-dev dwarves libtraceevent-dev libtracefs-dev dwarfdump \
        gcc-aarch64-linux-gnu devscripts qemu-user-static mtools dosfstools device-tree-compiler

# base
RUN apt-get install -y \
        git \
        sudo \
        subversion

# timezone
ENV TZ=Asia/Taipei
RUN DEBIAN_FRONTEND=noninteractive apt install -y tzdata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata

# zstd
RUN apt-get install -y zstd

# tools
RUN apt-get install -y vim repo gdisk gosu fdisk

# extract-dtb
RUN apt-get install -y python3-pip; \
    pip install extract-dtb --break-system-packages

# azcopy
RUN mkdir azcopy_install && \
    curl -L https://aka.ms/downloadazcopy-v10-linux -o azcopy_install/azcopy.tar.gz && \
    tar xvf azcopy_install/azcopy.tar.gz --strip-components=1 -C azcopy_install && \
    mv azcopy_install/azcopy /usr/local/bin/azcopy && \
    rm -rf azcopy_install && \
    chmod +x /usr/local/bin/azcopy

# audio-topology
RUN apt-get install -y alsa-utils

# locale
RUN apt-get install -y locales \
    && locale-gen en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
ENV LANG="en_US.UTF-8"

# entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
