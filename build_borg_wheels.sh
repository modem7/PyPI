#!/bin/bash

# Requirements: dumb-pypi
# pip install dumb-pypi

PKG_URL=https://raw.githubusercontent.com/modem7/PyPI/gh-pages/packages

docker run --rm -v "$(pwd)":/data -w /data -it 'arm64v8/alpine:3.16' sh -c './borgmatic/borgmatic_wheels.sh'

docker run --rm -v "$(pwd)":/data -w /data -it 'alpine:3.16' sh -c './borgmatic/borgmatic_wheels.sh'

dumb-pypi --package-list <(ls packages) \
   --packages-url $PKG_URL \
   --output-dir .