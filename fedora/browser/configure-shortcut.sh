#!/bin/bash

declare -r DIR=$(dirname ${BASH_SOURCE[0]})

declare -r FILE=brave-browser.desktop
declare -r ORIGINAL=/usr/share/applications/${FILE}
declare -r COPY=~/.local/share/applications/${FILE}

if [ -f ${ORIGINAL} ]; then
  echo "Copying file - ${ORIGINAL}" 
  cp ${ORIGINAL} ${COPY}
  sed -i "/--incognito/!s/\(^Exec=.*\)/\1 --incognito/" ${COPY}
  diff ${ORIGINAL} ${COPY}
fi
