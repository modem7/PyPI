#!/bin/sh

apk update && apk add --update --no-cache \
    alpine-sdk \
    linux-headers \
    py3-pkgconfig \
    py3-wheel \
    py3-pip \
    curl \
    autoconf \
    py3-cryptography \
    openssh \
    libffi-dev \
    musl-dev \
    python3-dev \
    openssl-dev \
    cargo \
    build-base \
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