FROM ubuntu:22.04

LABEL org.opencontainers.image.authors="Advantech"

ARG UNAME=adv

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color
ENV PATH="/opt/python3/bin:${PATH}"
ENV DTC_PATH=/usr/bin
ENV DTC=/usr/bin

#timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get upgrade -y \
    && apt install -y --no-install-recommends tzdata

RUN TZ=Asia/Taipei && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
    repo gawk wget git diffstat unzip texinfo gcc build-essential \
    chrpath socat cpio python3 python3-pip python3-pexpect xz-utils \
    debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa \
    libsdl1.2-dev pylint xterm python3-subunit mesa-common-dev zstd \
    liblz4-tool locales tar python-is-python3 file libxml-opml-simplegen-perl \
    vim whiptail g++ libacl1 \
    lib32stdc++6 libncurses5 checkinstall libreadline-dev libncursesw5-dev \
    libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev curl \
    sudo ftp libarchive-zip-perl locales whiptail clang-11 libgtest-dev gcc device-tree-compiler \
    gosu 

RUN mkdir -p /pkg/qct/software/boottools && \
    cp -r /usr/bin/dtc /pkg/qct/software/boottools

# Setup locales
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
RUN locale-gen en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# Install libffi6
RUN curl -LO http://archive.ubuntu.com/ubuntu/pool/main/libf/libffi/libffi6_3.2.1-8_amd64.deb && \
    dpkg -i libffi6_3.2.1-8_amd64.deb

RUN pip install requests; \
    pip install ruamel.yaml==0.17.17; \
    pip install dtschema==2021.10; \
    pip install jsonschema==4.0.0; \
    pip install extract-dtb; \
    pip install PyYAML; \
    pip install tqdm; \
    pip install gitpython; \
    pip install json-schema-for-humans;

RUN apt autoremove -y && apt clean -y && rm -f *.deb

# entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
