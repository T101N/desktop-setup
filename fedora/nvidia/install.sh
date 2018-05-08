#!/bin/bash

sudo dnf install \
    xorg-x11-drv-nvidia \
    xorg-x11-drv-nvidia-cuda
    akmod-nvidia \
    kernel-devel \
    nvidia-settings \
    nvidia-modprobe \
    nvidia-texture-tools \
    vulkan-devel

sudo dnf install \
    vdpauinfo \
    libva-vdpau-driver \
    libva-utils
