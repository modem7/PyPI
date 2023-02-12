#!/bin/sh

apk update && apk add --update --no-cache \
    acl-dev \
    alpine-sdk \
    attr-dev \
    bzip2-dev \
    fuse-dev \
    g++ \
    libcrypto1.1 \
    libffi-dev \
    libssl1.1 \
    linux-headers \
    lz4-dev \
    musl-dev \
    ncurses-dev \
    openssl-dev \
    py3-pip \
    py3-pkgconfig \
    py3-setuptools \
    py3-wheel \
    py3-xxhash \
    python3-dev \
    readline-dev \
    sqlite-dev \
    tree \
    xz-dev \
    zlib-dev

python3 -m pip install -U pkgconfig pip setuptools wheel && python3 -m pip wheel --no-cache-dir --wheel-dir ./packages/ -r borgmatic/requirements.txt -f ./packages/

arch=$(uname -m)
echo
echo
echo "Wheels created for $arch. Add to borgmatic project."
echo
echo "List of Wheels:"
echo
tree ./packages/