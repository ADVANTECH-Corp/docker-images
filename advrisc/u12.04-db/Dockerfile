# Internal Use for dailybuild

FROM advrisc/u12.04

MAINTAINER Advantech

# update to subversion-1.7
RUN apt-add-repository ppa:dominik-stadler/subversion-1.7
RUN apt-get update
RUN apt-get install -y subversion

# partd for loop device
RUN apt-get install -y parted

# qemu-user-static & rpm
RUN apt-get install -y rpm
RUN apt-get install -y qemu-user-static

# tool chain
ADD imx6LBV3510_2015-12-03_sdk.tgz /
RUN /imx6LBV3510_2015-12-03_sdk/poky-eglibc-x86_64-fsl-image-x11-cortexa9hf-vfp-neon-toolchain-qt4-1.5.3.sh -y
RUN rm -rf imx6LBV3510_2015-12-03_sdk