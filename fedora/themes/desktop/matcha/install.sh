#!/bin/bash

DIR=$(dirname ${BASH_SOURCE[0]})

THEME_NAME="matcha"
THEME_REPOSITORY="https://github.com/vinceliuice/${THEME_NAME}.git"

git clone ${THEME_REPOSITORY}

bash ./${THEME_NAME}/Install
