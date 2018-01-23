#!/bin/bash
DIR=$(dirname ${BASH_SOURCE[0]})

THEME_VERSION=1.4.7
THEME_FILE=v${THEME_VERSION}.tar.gz
THEME_TARGET_DESTINATION=~/.themes
EXTRACTED_ARCHIVE_DIR=OSX-Arc-Shadow-${THEME_VERSION}

LOG=/tmp/theme-install.log

mkdir -p ~/.themes
wget --no-clobber "https://github.com/LinxGem33/OSX-Arc-Shadow/archive/${THEME_FILE}" \
    -O /tmp/${THEME_FILE} >> ${LOG}
tar -xvf /tmp/${THEME_FILE} --directory=${THEME_TARGET_DESTINATION} >> ${LOG}
gsettings set org.gnome.desktop.interface gtk-theme ${EXTRACTED_ARCHIVE_DIR} >> ${LOG}
