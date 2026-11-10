FROM ubuntu:26.04

LABEL org.opencontainers.image.authors="Advantech"

RUN userdel -r ubuntu

ENV TERM=xterm-256color

# Ubuntu kernel
RUN sed -i '/Types: deb/{N;s/Types: deb\nURIs: http:\/\/archive\.ubuntu\.com\/ubuntu/Types: deb deb-src\nURIs: http:\/\/archive\.ubuntu\.com\/ubuntu/}' /etc/apt/sources.list.d/ubuntu.sources

# arm64 multiarch (cross-build the kernel tools: usbip, cpupower, perf, bpftool...)
RUN sed -i '/^URIs: http:\/\/\(archive\|security\)\.ubuntu\.com/i Architectures: amd64' /etc/apt/sources.list.d/ubuntu.sources; \
    printf '%s\n' \
        'Types: deb' \
        'URIs: http://ports.ubuntu.com/ubuntu-ports/' \
        'Suites: resolute resolute-updates resolute-backports resolute-security' \
        'Components: main universe restricted multiverse' \
        'Architectures: arm64' \
        'Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg' \
        > /etc/apt/sources.list.d/ubuntu-ports-arm64.sources; \
    dpkg --add-architecture arm64

RUN apt-get update; \
    apt-get build-dep -y linux; \
    apt-get install -y \
        fakeroot llvm libncurses-dev dwarves libtraceevent-dev libtracefs-dev dwarfdump \
        gcc-aarch64-linux-gnu g++-aarch64-linux-gnu devscripts qemu-user qemu-user-binfmt mtools dosfstools device-tree-compiler u-boot-tools; \
    # 26.04 qemu-user is already static, keep the old *-static name for rootfs scripts
    ln -sf qemu-aarch64 /usr/bin/qemu-aarch64-static

# arm64 libraries for the kernel tools
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        libaudit-dev:arm64 libbpf-dev:arm64 libcap-dev:arm64 libdebuginfod-dev:arm64 \
        libdw-dev:arm64 libelf-dev:arm64 libiberty-dev:arm64 liblzma-dev:arm64 \
        libnewt-dev:arm64 libnl-3-dev:arm64 libnl-genl-3-dev:arm64 libnuma-dev:arm64 \
        libpci-dev:arm64 libssl-dev:arm64 libtraceevent-dev:arm64 libtracefs-dev:arm64 \
        libudev-dev:arm64 libunwind-dev:arm64 libpython3-dev:arm64 uuid-dev:arm64 \
        libzstd-dev:arm64 zlib1g-dev:arm64

# Qualcomm addon PPA (kgsl-dkms / camx-dkms for the linux-qcom DKMS build)
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ubuntu-qcom-iot/qcom-ppa

# base
RUN apt-get install -y \
        git \
        git-lfs \
        sudo \
        subversion; \
        git lfs install --system

# timezone
ENV TZ=Asia/Taipei
RUN DEBIAN_FRONTEND=noninteractive apt install -y tzdata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata

# zstd
RUN apt-get install -y zstd

# tools
RUN apt-get install -y vim gdisk gosu fdisk

# repo (no longer packaged in 26.04)
RUN curl -fsSL https://storage.googleapis.com/git-repo-downloads/repo -o /usr/local/bin/repo && \
    chmod a+rx /usr/local/bin/repo

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

# qcom-ptool (GPT partition tables); PyYAML and jsonschema from apt, so
# 'pip install --break-system-packages -e qcom-ptool' only installs the tool
RUN apt-get install -y python3-yaml python3-jsonschema python3-setuptools

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
