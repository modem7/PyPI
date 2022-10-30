#!/bin/bash

# Requirements: 
# QEMU Emulation
## Install the qemu packages:
### sudo apt-get install qemu binfmt-support qemu-user-static
## Execute the registering scripts:
### docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

PUID=$(id -u)
PGID=$(id -g)
UPLOADER=modem7
IMG=python:3.10.6-alpine3.16
SCRIPT=./borgmatic/borgmatic_wheels.sh
PKG_URL=https://raw.githubusercontent.com/modem7/PyPI/master/packages
# https://github.com/docker-library/official-images#architectures-other-than-amd64
PLATFORMARM32="linux/arm/v7"
PLATFORMARM64="linux/arm64/v8"
PLATFORMAMD64="linux/amd64"

sudo chown -R $PUID:$PGID .

docker run --rm --name "x86" --platform $PLATFORMARM32 -v "$(pwd)":/data -w /data $IMG sh -c $SCRIPT &
docker run --rm --name "arm32" --platform $PLATFORMARM64 -v "$(pwd)":/data -w /data $IMG sh -c $SCRIPT &
docker run --rm --name "arm64" --platform $PLATFORMAMD64 -v "$(pwd)":/data -w /data $IMG sh -c $SCRIPT &
wait

# Create package.json
echo Creating package.json
git ls-files | xargs -I{} git log -1 --date=format:%Y%m%d%H%M.%S --format='touch -t %ad "{}"' "{}" | $SHELL
echo -n > packages.json
for FILE in $(ls packages | sed -e 's/"/\\"/g')
do
TIMESTAMP=$(date -r packages/${FILE} +%s)
echo -en {\"filename\": \"${FILE}\", \"uploaded_by\": \"${UPLOADER}\", \"upload_timestamp\": ${TIMESTAMP}\} '\n' >> packages.json
done

# Create index
echo Creating Index
docker run --rm --user=$PUID:$PGID -v "$(pwd)":/data -w /data -e PKG_URL=$PKG_URL -it modem7/dumb-pypi sh -c 'dumb-pypi \
   --package-list-json packages.json \
   --packages-url $PKG_URL \
   --output-dir .'

