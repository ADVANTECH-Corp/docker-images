# About
This Docker image can support the following Qualcomm QCA4531 projects.

- WISE-3200

# Usage
## Get BSP sources

[WISE-3200]

```
$ git clone http://advgitlab.eastasia.cloudapp.azure.com/WISE-EC/WISE-3200.git
$ cd WISE-3200
$ git submodule init
$ git submodule update
```

## Build BSP

[WISE-3200]

```
$ cd qsdk
$ make package/symlinks
$ cp qca/configs/advantech/wise-3200.config .config
$ make defconfig
$ make V=s
```

# Dockerfile links
- [latest (advrisc/u14.04-4531OBV1/Dockerfile)](https://github.com/ADVANTECH-Corp/docker-images/blob/u14.04-4531OBV1/advrisc/u14.04-4531OBV1/Dockerfile)

