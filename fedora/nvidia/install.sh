#!/bin/bash

sudo dnf install -y \
    xorg-x11-drv-nvidia \
    xorg-x11-drv-nvidia-cuda \
    akmod-nvidia \
    kernel-devel \
    nvidia-settings \
    nvidia-modprobe \
    nvidia-texture-tools \
    nvidia-xconfig \
    vulkan-devel

sudo dnf install -y \
    vdpauinfo \
    libva-vdpau-driver \
    libva-utils
