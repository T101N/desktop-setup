#!/bin/bash
DIR=$(dirname ${BASH_SOURCE[0]})

sudo nvidia-xconfig --cool-bits=4
echo "GPU_FAN_SPEED=35" >> ~/.profile
echo "nvidia-settings -a \"[gpu:0]/GPUFanControlState=1\" -a \"[fan:0]/GPUTargetFanSpeed=\${GPU_FAN_SPEED}\"" >> ~/.profile
