#!/bin/sh

apk update && apk add --update --no-cache \
    alpine-sdk \
    linux-headers \
    py3-pip \
    py3-pkgconfig \
    py3-wheel \
    tree

python3 -m pip install --no-cache-dir --upgrade --upgrade-strategy='eager' \
        'setuptools' \
        'pip' \
        'wheel'

python3 -m pip wheel --no-cache-dir --wheel-dir ./packages/ -r dumb-pypi/requirements.txt -f ./packages/

arch=$(uname -m)
echo
echo
echo "List of Wheels:"
echo
tree ./packages/