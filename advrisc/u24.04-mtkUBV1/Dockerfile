FROM ubuntu:24.04

LABEL maintainer="Advantech"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git subversion tzdata gawk wget git-core diffstat unzip \
    texinfo gcc-multilib g++-multilib build-essential chrpath \
    socat cpio python3 python3-pip python3-pexpect bc \
    device-tree-compiler xz-utils debianutils iputils-ping \
    python3-git python3-jinja2 libegl1-mesa-dev libsdl1.2-dev \
    xterm rsync curl zstd lz4 libssl-dev openjdk-11-jdk \
    gnupg flex bison gperf zip x11proto-core-dev ccache \
    adb fastboot xsltproc libelf-dev dwarves libncurses6 libncurses-dev \
    clang openssh-server libarchive-zip-perl vim sudo ftp \
    debhelper locales kmod shim-signed && \
    apt-get clean

RUN apt-get update && apt-get install -y \
    gcc-aarch64-linux-gnu g++-aarch64-linux-gnu \
    gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf \
    libc6-dev-arm64-cross libc6-dev-armhf-cross && \
    apt-get clean

RUN apt-get update && apt-get install -y \
    rustc cargo clang llvm libclang-dev bindgen rust-src && \
    apt-get clean && \
    ln -s /usr/bin/bindgen /usr/local/bin/bindgen-0.65 && \
    rm -rf /var/run/sshd

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN usermod -l adv -d /home/adv -m ubuntu && \
    groupmod -n adv ubuntu && \
    echo "adv:adv" | chpasswd && \
    echo "adv ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN mkdir -p /var/lib/shim-signed/mok/ && \
    openssl req -new -x509 -newkey rsa:2048 \
    -keyout /var/lib/shim-signed/mok/MOK.key \
    -out /var/lib/shim-signed/mok/MOK.der \
    -nodes -days 3650 \
    -subj "/CN=Advantech MTK Kernel Build Key/O=Advantech/OU=RISC/"

USER adv
WORKDIR /home/adv
ENV HOME=/home/adv
ENV USER=adv

RUN git config --global user.email "you@example.com" && \
    git config --global user.name "Your Name" && \
    git config --global color.ui "auto"

RUN mkdir -p ${HOME}/bin && \
    curl https://storage.googleapis.com/git-repo-downloads/repo > ${HOME}/bin/repo && \
    chmod a+x ${HOME}/bin/repo

ENV PATH="/home/adv/bin:${PATH}"

CMD ["/bin/bash"]
