#!/bin/bash

# This script is mostly in case a re-index of PyPi needs doing. 

PUID=$(id -u)
PGID=$(id -g)
UPLOADER=modem7
PKG_URL=https://raw.githubusercontent.com/modem7/PyPI/master/packages

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
