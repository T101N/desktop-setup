#!/bin/bash

#####  Install nodejs  #####

# Install guide - https://nodejs.org/en/download/package-manager/#enterprise-linux-and-fedora
NODE_VERSION=10.x
curl --silent --location https://rpm.nodesource.com/setup_${NODE_VERSION} \
    | sudo bash - \
    && sudo dnf -y install nodejs \
    && sudo dnf install gcc-c++ make 

# Fixing permissions - https://docs.npmjs.com/getting-started/fixing-npm-permissions
mkdir -p ~/.npm-global \
    && npm config set prefix '~/.npm-global' \
    && echo "export PATH=\$PATH:~/.npm-global/bin" >> ~/.profile
    # && echo "source ~/.profile" >> ~/.bashrc 

source ~/.profile
