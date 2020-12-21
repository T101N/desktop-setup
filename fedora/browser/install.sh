#!/bin/bash

declare -r DIR=$(dirname ${BASH_SOURCE[0]})

sudo dnf install -y dnf-plugins-core \
    && sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/ \
    && sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc \
    && sudo dnf install -y brave-browser

bash $DIR/configure-shortcut.sh
