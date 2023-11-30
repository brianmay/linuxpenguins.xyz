#!/bin/sh
set -ex

if [ -n "$(git status --porcelain)" ]; then
    echo "Working directory is not clean" >&2
    exit 1
fi

VCS_REF="$(git rev-parse HEAD)"
BUILD_DATE="$(date --iso-8601=seconds)"
sed -i 's,SHA,'"$VCS_REF"',' html/index.html
sed -i 's,REF,'"$BUILD_DATE"',' html/index.html
rsync -av --delete html/ --exclude "brian" brian@master.linuxpenguins.xyz:/var/www/html
git checkout html/index.html
