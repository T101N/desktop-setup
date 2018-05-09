#!/bin/bash
DIR=$(dirname ${BASH_SOURCE[0]})

TILIX_SCHEMES_DIR=~/.config/tilix/schemes

sudo apt install tilix tilix-common

mkdir -p ${TILIX_SCHEMES_DIR}
cp ${DIR}/Custom.json ${TILIX_SCHEMES_DIR}/
