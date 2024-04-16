FROM ubuntu:18.04

MAINTAINER Advantech

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y subversion
#timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get install -y diffstat xmlstarlet texinfo chrpath gcc-aarch64-linux-gnu libarchive-dev ssh libselinux1-dev fakechroot 
RUN apt-get install -y g++-aarch64-linux-gnu libiberty-dev qemu-user-static g++ gawk gcc make libwayland-dev fakeroot libpam0g-dev openjdk-8-jdk-headless 
RUN apt-get install -y binutils-dev util-linux zstd liblz4-tool libxml2-utils build-essential wget git-core unzip python python3-pip python3-pexpect 
RUN apt-get install -y socat cpio xz-utils iputils-ping python3-git python3-jinja2 
RUN apt-get update
RUN apt-get install -y libegl1-mesa libsdl1.2-dev pylint3 xterm flex bison vim rsync sudo 
RUN apt-get install -y curl libtinfo5 swig uuid-dev libc6-i386 lib32stdc++6 libssl-dev libyaml-dev libffi-dev

RUN wget https://www.python.org/ftp/python/3.8.16/Python-3.8.16.tgz
RUN tar -xf Python-3.8.16.tgz -C /tmp
WORKDIR /tmp/Python-3.8.16/
RUN ./configure --enable-optimizations
RUN make
RUN make altinstall

RUN ln -sf /usr/local/bin/python3.8 /usr/bin/python
RUN ln -sf /usr/local/bin/pip3.8 /usr/bin/pip3
RUN pip3 install scons
RUN pip3 install dtschema==2021.10
RUN pip3 install jsonschema==4.0.0
RUN pip3 install ruamel.yaml==0.17.17

RUN wget https://pyyaml.org/download/libyaml/yaml-0.2.3.tar.gz
RUN tar -xf yaml-0.2.3.tar.gz -C /tmp
WORKDIR /tmp/yaml-0.2.3/
RUN ./configure
RUN make
RUN make install

RUN git clone https://git.kernel.org/pub/scm/utils/dtc/dtc.git
RUN mv dtc/ /opt/.
WORKDIR /opt/dtc/
RUN make
RUN python setup.py install

RUN mkdir -p ~/bin
RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
RUN chmod a+x ~/bin/repo
RUN export PATH=~/bin:$PATH
RUN export PATH=${PATH}:~/.local/bin
RUN echo "export PATH=~/bin:$PATH" >> ~/.bashrc

RUN ln -sf /bin/bash /bin/sh
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
RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ${HOME}/bin/repo
RUN chmod a+x ${HOME}/bin/repo
ENV PATH="/home/adv/bin:${PATH}"

ENV USER adv

# locale
RUN sudo apt-get install -y locales
RUN sudo locale-gen en_US.UTF-8
RUN sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG="en_US.UTF-8"

