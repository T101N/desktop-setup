#!/bin/bash
set -e
DIR=$(cd $(dirname ${BASH_SOURCE[0]}) 2>&1 > /dev/null && pwd)

source ${DIR}/.variables

declare ARCHIVE_NAME=${ARCHIVE_NAME:-"postman.tar.gz"}
declare EXTRACTED_DIR=${EXTRACTED_DIR:-"Postman"}
declare INSTALL_DIR=${INSTALL_DIR:-"/opt/postman"}
declare WORKDIR=${WORKDIR:-"/tmp"}

declare DESKTOP_FILE=${DESKTOP_FILE:-"postman.desktop"}
declare DESKTOP_DIR=${DESKTOP_DIR:-"~/.local/share/application"}

rm -rf ${INSTALL_DIR} \
    && rm ${DESKTOP_DIR}/${DESKTOP_FILE}
