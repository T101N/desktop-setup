#!/bin/bash
set -e
DIR=$(cd $(dirname ${BASH_SOURCE[0]}) 2>&1 > /dev/null && pwd)

source ${DIR}/.variables

declare ARCHIVE_NAME=${ARCHIVE_NAME:-"postman.tar.gz"}
declare EXTRACTED_DIR=${EXTRACTED_DIR:-"Postman"}
declare INSTALL_DIR=${INSTALL_DIR:-"/opt/postman"}
declare WORKDIR=${WORKDIR:-"/tmp"}

declare USER=${USER}

#     && curl -o ${WORKDIR}/${ARCHIVE_NAME} https://dl.pstmn.io/download/latest/linux_64 \

# sudo mkdir -p ${INSTALL_DIR} \
#     && sudo chown ${USER}:${USER} ${INSTALL_DIR} \
    tar -xzf ${WORKDIR}/${ARCHIVE_NAME} -C ${INSTALL_DIR} \
    && cp -f ${DIR}/postman.desktop ${INSTALL_DIR}/postman.desktop \
    && ln -s ${INSTALL_DIR}/postman.desktop ~/.local/share/applications/postman.desktop \
