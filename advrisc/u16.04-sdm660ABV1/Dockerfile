# for SDM660
FROM ubuntu:16.04

MAINTAINER Advantech

# update
RUN apt-get update

# from SDM660 user guide
RUN apt-get install -y uuid uuid-dev
RUN apt-get install -y zlib1g-dev liblz-dev
RUN apt-get install -y liblzo2-2 liblzo2-dev
RUN apt-get install -y lzop
RUN apt-get install -y git-core curl
RUN apt-get install -y u-boot-tools
RUN apt-get install -y mtd-utils
RUN apt-get install -y android-tools-fsutils
RUN apt-get install -y gdisk
RUN apt-get install -y libz-dev
RUN apt-get install -y m4

RUN apt-get install -y gnupg flex bison gperf build-essential zip gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev
RUN apt-get install -y libx11-dev lib32z1-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip

RUN apt-get install -y tofrodos
RUN apt-get install -y python-markdown
#RUN apt-get install -y uuid-dev:i386 liblzo2-dev:i386
RUN apt-get install -y gcc-multilib g++-multilib
RUN apt-get install -y subversion
RUN apt-get install -y openssh-server openssh-client
RUN apt-get install -y libssl-dev
RUN apt-get install -y bc
RUN apt-get install -y kmod
RUN apt-get install -y clang
RUN apt-get install -y cmake

# jenkins
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN apt-get update

# openjdk
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk

# crc32
RUN apt-get install -y libarchive-zip-perl

# tools
RUN apt-get install -y vim
RUN apt-get install -y sudo
RUN apt-get install -y ftp

#set amss env
RUN cd tool
RUN unzip hexagon.lnx.8.0_installer_08008.102-11-20_02_13_48.zip
RUN tar xvf Hexagon_LNX_8_0_Installer_08008_1.tar
RUN chmod +x Hexagon.LLVM_linux_installer_8.0.08.bin
RUN ./excuteHexg 
RUN cp -af /opt/Qualcomm/HEXAGON_Tools/8.0.08  /opt/Qualcomm/HEXAGON_Tools/8.0.09

RUN tar xvf snapdragon_sd_llvm_arm.lnx.3.7_installer_37600.1.tar
RUN mkdir 3.7.6
RUN tar -zxvf Snapdragon-llvm-3.7.6-linux64.tar.gz -C ./3.7.6
RUN mkdir -p /opt/LLVM/
RUN mv ./3.7.6 /opt/LLVM/

RUN tar xvf snapdragon_sd_llvm_arm.lnx.3.8_installer_38400.1.tar
RUN mkdir 3.8.4
RUN tar -zxvf Snapdragon_LLVM_ARM_linux_3.8.4.tar.gz -C ./3.8.4
RUN mkdir -p /opt/LLVM/
RUN mv ./3.8.4 /opt/LLVM/

RUN tar xvf snapdragon_sd_llvm_arm.lnx.3.9_installer_39200.2.tar
RUN mkdir 3.9.2
RUN mkdir 3.9.4
RUN tar -zxvf Snapdragon-llvm-3.9.2-linux64.tar.gz -C ./3.9.2
RUN tar -zxvf Snapdragon-llvm-3.9.2-linux64.tar.gz -C ./3.9.4
RUN mkdir -p /opt/LLVM/
RUN mv ./3.9.2 /opt/LLVM/
RUN mv ./3.9.4 /opt/LLVM/

RUN tar Jxvf gcc-linaro-arm-linux-gnueabihf-4.9-2014.05_linux.tar.xz
RUN mv ./gcc-linaro-arm-linux-gnueabihf-4.9-2014.05_linux /opt
RUN tar Jxvf gcc-linaro-aarch64-none-elf-4.9-2014.07_linux.tar.xz
RUN mv ./gcc-linaro-aarch64-none-elf-4.9-2014.07_linux /opt

RUN tar xvfz perl-5.22.1.tar.gz
RUN cd perl-5.22.1
RUN ./Configure -Duseithreads -des 
RUN make 
RUN make test 
RUN make install /usr/local/bin/cpan

RUN cp -af ARM_Compiler_5 /opt/

RUN cd ..

# networking
#RUN apt-get install -y ping net-tools

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
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > ${HOME}/bin/repo
RUN chmod a+x ${HOME}/bin/repo
ENV PATH="/home/adv/bin:${PATH}"

#ENV JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredC ompilation -Xmx4g"
# android
ENV USER adv

