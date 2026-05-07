FROM ubuntu:22.04

LABEL org.opencontainers.image.authors="Advantech"

ARG UNAME=adv

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color
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
    pipx

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

# azcopy
RUN mkdir azcopy_install && \
    curl -L https://aka.ms/downloadazcopy-v10-linux -o azcopy_install/azcopy.tar.gz && \
    tar xvf azcopy_install/azcopy.tar.gz --strip-components=1 -C azcopy_install && \
    mv azcopy_install/azcopy /usr/local/bin/azcopy && \
    rm -rf azcopy_install && \
    chmod +x /usr/local/bin/azcopy

# repo
RUN curl https://raw.githubusercontent.com/GerritCodeReview/git-repo/v2.41/repo -o /usr/local/bin/repo && \
    chmod +x /usr/local/bin/repo

# Change sh symlink to point to bash for qirp image
RUN ln -sf /bin/bash /bin/sh

# Create user
RUN useradd -m -k /home/${UNAME} ${UNAME} -p ajLGz61mdCP76 -s /bin/bash -G sudo && \
    echo "${UNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /home/${UNAME}
USER ${UNAME}

ENV USER=${UNAME}
ENV HEXAGON_ROOT=~/Qualcomm/HEXAGON_Tools

# Setup git environment
RUN git config --global user.email "you@example.com" && \
    git config --global user.name "Your Name" && \
    git config --global color.ui auto && \
    git config --global http.postBuffer 1048576000 && \
    git config --global http.maxRequestBuffer 1048576000 && \
    git config --global http.lowSpeedLimit 0 && \
    git config --global http.lowSpeedTime 999999 && \
    git config --global http.https://chipmaster2.qti.qualcomm.com.followRedirects true && \
    git config --global http.https://qpm-git.qualcomm.com.followRedirects true

RUN sudo cp /etc/skel/.bashrc /home/${UNAME} && sudo chown adv:adv /home/${UNAME}/.bashrc

# kas
ENV PATH="/home/${UNAME}/.local/bin:${PATH}"
RUN pipx ensurepath
RUN pipx install kas

CMD ["/bin/bash"]
