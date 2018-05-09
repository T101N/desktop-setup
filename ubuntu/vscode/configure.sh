#!/bin/bash
DIR=$(dirname ${BASH_SOURCE[0]})
SOURCE_DIRECTORY=${DIR}
TARGET_DIRECTORY=~/.config/Code/User

mkdir -pv ${TARGET_DIRECTORY}
cp -nv ${SOURCE_DIRECTORY}/keybindings.json ${TARGET_DIRECTORY}/keybindings.json
cp -nv ${SOURCE_DIRECTORY}/settings.json ${TARGET_DIRECTORY}/settings.json