#!/bin/sh

apk update && apk add --update --no-cache \
    alpine-sdk \
    linux-headers \
    py3-pkgconfig \
    py3-wheel \
    py3-xxhash \
    py3-setuptools \
    py3-pip \
    python3-dev \
    openssl-dev \
    lz4-dev \
    acl-dev \
    fuse-dev \
    attr-dev \
    zlib-dev \
    bzip2-dev \
    ncurses-dev \
    readline-dev \
    xz-dev \
    sqlite-dev \
    libffi-dev \
    tree

python3 -m pip install -U pkgconfig pip setuptools wheel && python3 -m pip wheel --no-cache-dir --wheel-dir ./packages/ -r borgmatic/requirements.txt -f ./packages/

arch=$(uname -m)
echo
echo
echo "Wheels created for $arch. Add to borgmatic project."
echo
echo "List of Wheels:"
echo
tree ./packages/