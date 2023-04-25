FROM ubuntu:20.04

MAINTAINER Advantech

ENV DEBIAN_FRONTEND=noninteractive

# update
RUN apt-get update
RUN apt-get upgrade
RUN apt install -y gnupg ca-certificates
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
#RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" >> /etc/apt/sources.list.d/mono-official-stable.list
RUN apt-get update
RUN apt-get install -y attr build-essential python3.8 python3.8-dev python3.8-venv device-tree-compiler bison flex swig iasl uuid-dev wget git bc libssl-dev zlib1g-dev python3-pip mono-devel gawk libgnutls28-dev

# adv account
RUN useradd -m -k /home/adv adv -p ajLGz61mdCP76 -s /bin/bash -G sudo

# set up adv as sudo
RUN echo "adv ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
WORKDIR /home/adv
USER adv

# git config
RUN git config --global user.email "you@example.com"
RUN git config --global user.name "Your Name"
RUN git config --global color.ui "auto"

ENV USER adv
