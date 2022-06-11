#!/bin/bash

# Requirements: 
## dumb-pypi:
### pip install dumb-pypi
#
## QEMU Emulation
### Install the qemu packages:
### sudo apt-get install qemu binfmt-support qemu-user-static
## Execute the registering scripts:
### docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

PKG_URL=https://raw.githubusercontent.com/modem7/PyPI/gh-pages/packages
ALPINE_X86=alpine:3.16
ALPINE_ARM64=arm64v8/python:3.10.5-alpine3.16
ALPINE_ARMV6=arm32v6/python:3.10.5-alpine3.16
ALPINE_ARMV7=arm32v7/python:3.10.5-alpine3.16

docker run --rm -v "$(pwd)":/data -w /data -it $ALPINE_ARM64 sh -c './dumb-pypi/dumb_pypi_wheels.sh'

docker run --rm -v "$(pwd)":/data -w /data -it $ALPINE_ARMV6 sh -c './dumb-pypi/dumb_pypi_wheels.sh'

docker run --rm -v "$(pwd)":/data -w /data -it $ALPINE_ARMV7 sh -c './dumb-pypi/dumb_pypi_wheels.sh'

docker run --rm -v "$(pwd)":/data -w /data -it $ALPINE_X86 sh -c './dumb-pypi/dumb_pypi_wheels.sh'

dumb-pypi --package-list <(ls packages) \
   --packages-url $PKG_URL \
   --output-dir .