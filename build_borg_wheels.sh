#!/bin/bash

# Requirements: 
## QEMU Emulation
### Install the qemu packages:
### sudo apt-get install qemu binfmt-support qemu-user-static
## Execute the registering scripts:
### docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

PKG_URL=https://raw.githubusercontent.com/modem7/PyPI/gh-pages/packages
ALPINE_X86=alpine:3.16
ALPINE_ARM64=arm64v8/alpine:3.16

docker run --rm -v "$(pwd)":/data -w /data -it $ALPINE_ARM64 sh -c './borgmatic/borgmatic_wheels.sh'

docker run --rm -v "$(pwd)":/data -w /data -it $ALPINE_X86 sh -c './borgmatic/borgmatic_wheels.sh'

docker run --rm -v "$(pwd)":/data -w /data -e PKG_URL=$PKG_URL -it modem7/dumb-pypi sh -c 'dumb-pypi --package-list <(ls packages) \
   --packages-url $PKG_URL \
   --output-dir .'