FROM ubuntu:22.04

LABEL org.opencontainers.image.authors="Advantech"

ARG UNAME=adv
# [QLI2.1] Pinned pyenv release (2026-10-26), verified to provide Python 3.12.7
ARG PYENV_TAG=v2.8.14

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color
ENV DTC_PATH=/usr/bin
ENV DTC=/usr/bin
# [QLI2.1] pyenv shims are on PATH so the build scripts can select Python per
# step with PYENV_VERSION (e.g. PYENV_VERSION=3.12.7 for QLI2.1 Boot/DSP).
# The pyenv global version is "system", so the default python/python3 stays
# the system Python 3.10 used by the other steps.
ENV PYENV_ROOT=/opt/pyenv
ENV PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:/opt/python3/bin:${PATH}"

#timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get upgrade -y \
    && apt install -y --no-install-recommends tzdata

RUN TZ=Asia/Taipei && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# [QLI2.1] Last line adds the build dependencies pyenv needs to compile Python
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
    zlib1g-dev libxml2-dev libxmlsec1-dev liblzma-dev

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

# System Python 3.10 packages. One command with retries, so a network failure
# fails the image build instead of silently skipping a package.
RUN for i in 1 2 3 4 5; do \
      pip install --retries 10 --timeout 120 \
        requests ruamel.yaml==0.17.17 dtschema==2021.10 jsonschema==4.0.0 \
        extract-dtb PyYAML tqdm gitpython json-schema-for-humans && break; \
      [ $i -eq 5 ] && exit 1; echo "pip install failed, retry $i"; sleep 10; \
    done

# [QLI2.1] Install pyenv (pinned) and build Python 3.12.7.
# Clone and install are separate layers with retries, so a network failure
# only reruns the failed step.
RUN for i in 1 2 3 4 5; do \
      rm -rf ${PYENV_ROOT}; \
      git clone --depth 1 -b ${PYENV_TAG} https://github.com/pyenv/pyenv.git ${PYENV_ROOT} && break; \
      [ $i -eq 5 ] && exit 1; echo "git clone failed, retry $i"; sleep 10; \
    done

RUN for i in 1 2 3 4 5; do \
      pyenv install -s 3.12.7 && break; \
      [ $i -eq 5 ] && exit 1; echo "pyenv install failed, retry $i"; sleep 10; \
    done && \
    pyenv global system

# [QLI2.1] Python 3.12.7 packages for QLI2.1 Boot (QCS6490/IQ-9075) and IQ-9075 DSP.
# setuptools provides pkg_resources (needed by the Boot dtschema check) and is
# not bundled with Python 3.12; setuptools>=81 drops pkg_resources.
# Retries, a longer timeout and an outer retry loop are used to tolerate a slow
# network (pip --retries does not retry a read timeout in the middle of a download).
RUN for i in 1 2 3 4 5; do \
      PYENV_VERSION=3.12.7 python -m pip install --retries 10 --timeout 120 \
        "setuptools<81" ruamel.yaml==0.17.17 dtschema==2021.10 jsonschema==4.0.0 \
        json-schema-for-humans && break; \
      [ $i -eq 5 ] && exit 1; echo "pip install failed, retry $i"; sleep 10; \
    done

# [QLI2.1] "python -m pip install" through the pyenv shims runs "pyenv rehash",
# which fails when the build user (any UID in CI) cannot write the shims directory.
RUN chmod 777 ${PYENV_ROOT}/shims

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

# Create user
# [QLI2.1] The home directory is made world-readable because the pyenv shims
# fail when the current directory is not accessible (e.g. CI running as another UID).
RUN useradd -m -k /home/${UNAME} ${UNAME} -p ajLGz61mdCP76 -s /bin/bash -G sudo && \
    echo "${UNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    chmod 755 /home/${UNAME}

WORKDIR /home/${UNAME}
USER ${UNAME}

ENV USER=${UNAME}
ENV HEXAGON_ROOT=/home/${UNAME}/Qualcomm/HEXAGON_Tools

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

CMD ["/bin/bash"]
