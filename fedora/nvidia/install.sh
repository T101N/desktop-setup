#!/bin/bash
# Install nvidia drivers using negativo17 repo
#https://negativo17.org/nvidia-driver/
sudo dnf config-manager --add-repo=https://negativo17.org/repos/fedora-nvidia.repo \
  && sudo dnf check-update \
  && sudo dnf install -y nvidia-settings kernel-devel dkms-nvidia \
      vulkan.i686 nvidia-driver-libs.i686 nvidia-driver-cuda \
      nvidia-xconfig \
  && sudo nvidia-xconfig --cool-bits=4

# Set activate fan control and set fan speed (in %)
FAN_SPEED=35
echo "nvidia-settings -a \"[gpu:0]/GPUFanControlState=1\" -a \"[fan:0]/GPUTargetFanSpeed=$FAN_SPEED\"" >> ~/.profile
