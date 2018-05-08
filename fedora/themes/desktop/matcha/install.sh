#!/bin/bash

DIR=$(dirname ${BASH_SOURCE[0]})
THEME_NAME="matcha"
CLONE_DIR=/tmp/${THEME_NAME}
THEME_REPOSITORY="https://github.com/vinceliuice/${THEME_NAME}.git"

git clone ${THEME_REPOSITORY} ${CLONE_DIR}
bash ${CLONE_DIR}/Install
