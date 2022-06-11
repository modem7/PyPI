#!/bin/bash

# Requirements: 
# QEMU Emulation
## Install the qemu packages:
### sudo apt-get install qemu binfmt-support qemu-user-static
## Execute the registering scripts:
### docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

IMG=alpine:3.16
SCRIPT=./borgmatic/borgmatic_wheels.sh
PKG_URL=https://raw.githubusercontent.com/modem7/PyPI/gh-pages/packages
# https://github.com/docker-library/official-images#architectures-other-than-amd64
ALPINE_X86=${IMG}
# ALPINE_ARMV6=arm32v6/${IMG} - builds for armv6 and armv7 both come under armv7l
ALPINE_ARMV7=arm32v7/${IMG}
ALPINE_ARM64=arm64v8/${IMG}

docker run --rm -v "$(pwd)":/data -w /data $ALPINE_ARM64 sh -c $SCRIPT &
# docker run --rm -v "$(pwd)":/data -w /data $ALPINE_ARMV6 sh -c $SCRIPT &
docker run --rm -v "$(pwd)":/data -w /data $ALPINE_ARMV7 sh -c $SCRIPT &
docker run --rm -v "$(pwd)":/data -w /data $ALPINE_X86 sh -c $SCRIPT &
wait

docker run --rm -v "$(pwd)":/data -w /data -e PKG_URL=$PKG_URL -it modem7/dumb-pypi sh -c 'dumb-pypi --package-list <(ls packages) \
   --packages-url $PKG_URL \
   --output-dir .'
