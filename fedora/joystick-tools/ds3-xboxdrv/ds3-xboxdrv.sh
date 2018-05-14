#!/bin/bash
DIR=$(dirname ${BASH_SOURCE[0]})
source ${DIR}/.variables

xboxdrv \
    -c ${DIR}/${CONFIG_FILE} \
    --force-feedback \
    --evdev ${DEVICE}
