#!/bin/bash

DIR=$(cd $(dirname ${BASH_SOURCE[0]}) 2>&1 > /dev/null && pwd)
LOWER_GPU_POWER_SERVICE=lower-gpu-power.service

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

sudo cp -f ${DIR}/${LOWER_GPU_POWER_SERVICE} /etc/systemd/system/${LOWER_GPU_POWER_SERVICE} \
    && sudo systemctl enable ${LOWER_GPU_POWER_SERVICE} \
    && sudo systemctl start ${LOWER_GPU_POWER_SERVICE}
