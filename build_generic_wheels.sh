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
IMG=python:3.10-alpine3.16
SCRIPT=./generic/generic_wheels.sh
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

# Create package.json
git ls-files | xargs -I{} git log -1 --date=format:%Y%m%d%H%M.%S --format='touch -t %ad "{}"' "{}" | $SHELL
echo -n > packages.json
for FILE in $(ls packages | sed -e 's/"/\\"/g')
do
TIMESTAMP=$(date -r packages/${FILE} +%s)
echo -en {\"filename\": \"${FILE}\", \"uploaded_by\": \"${UPLOADER}\", \"upload_timestamp\": ${TIMESTAMP}\} '\n' >> packages.json
done

# Create index
docker run --rm --user=$PUID:$PGID -v "$(pwd)":/data -w /data -e PKG_URL=$PKG_URL -it modem7/dumb-pypi sh -c 'dumb-pypi \
   --package-list-json packages.json \
   --packages-url $PKG_URL \
   --output-dir .'

