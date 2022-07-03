#!/bin/bash

DIR="$(dirname ${BASH_SOURCE[0]})"

sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install -y dconf-editor \
  gnome-tweaks \
  chrome-gnome-shell

sudo dnf install -y cmake \
  libsigc++-devel
