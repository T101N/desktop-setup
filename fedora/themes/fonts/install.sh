#!/bin/bash

# Installing this may require rpm fusion free and non-free repos to be enabled.
DIR=$(dirname ${BASH_SOURCE[0]})
sudo dnf install freetype-freeworld \
    && mkdir -p ~/.config/fontconfig \
    && cp ${DIR}/fonts.conf ~/.config/
