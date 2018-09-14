#!/bin/bash
set -e
DIR=$(cd $(dirname ${BASH_SOURCE[0]}) 2>&1 > /dev/null && pwd)

source ${DIR}/.variables

declare ARCHIVE_NAME=${ARCHIVE_NAME:-"postman.tar.gz"}
declare EXTRACTED_DIR=${EXTRACTED_DIR:-"Postman"}
declare INSTALL_DIR=${INSTALL_DIR:-"/opt/postman"}
declare WORKDIR=${WORKDIR:-"/tmp"}

# mkdir -p ${INSTALL_DIR} \
#     && curl -o ${WORKDIR}/${ARCHIVE_NAME} https://dl.pstmn.io/download/latest/linux64 \
#     && tar -xzf ${WORKDIR}/${ARCHIVE_NAME} \
#     && sudo mv -f ${WORKDIR}/${EXTRACTED_DIR} ${INSTALL_DIR} \
    cp ${DIR}/postman.desktop ${INSTALL_DIR}/postman.desktop \
    && ln -s ${INSTALL_DIR}/postman.desktop ~/.local/share/applications/postman.desktop
    