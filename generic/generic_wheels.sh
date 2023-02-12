#!/bin/sh

apk update && apk add --update --no-cache \
    alpine-sdk \
    autoconf \
    build-base \
    cargo \
    curl \
    g++ \
    libffi-dev \
    linux-headers \
    musl-dev \
    openssh \
    openssl-dev \
    py3-cryptography \
    py3-pip \
    py3-pkgconfig \
    py3-wheel \
    python3-dev \
    tree

python3 -m pip install --no-cache-dir --upgrade \
        'setuptools' \
        'pip' \
        'wheel'

python3 -m pip wheel --no-cache-dir --wheel-dir ./packages/ -r generic/requirements.txt -f ./packages/

arch=$(uname -m)
echo
echo
echo "List of Wheels:"
echo
tree ./packages/