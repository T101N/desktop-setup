#!/bin/bash

sudo dnf install -y java-latest-openjdk-devel

curl -s "https://get.sdkman.io" | bash \
    && source "$HOME/.sdkman/bin/sdkman-init.sh" \
    && sdk install gradle 7.4
