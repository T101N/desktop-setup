#!/bin/bash

sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Installing this requires rpm fusion to be enabled for freetype-freeworld.
DIR=$(dirname ${BASH_SOURCE[0]})
sudo dnf install freetype-freeworld \
    && mkdir -p ~/.config/fontconfig \
    && cp ${DIR}/fonts.conf ~/.config/
