#!/bin/bash

sudo dnf install -y dnf-plugins-core \
    && sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/ \
    && sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc \
    && sudo dnf install -y brave-browser

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
