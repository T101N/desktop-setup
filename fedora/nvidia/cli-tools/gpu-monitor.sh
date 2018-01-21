#!/bin/bash
TEMP=$(nvidia-settings -q [gpu:0]/GPUCoreTemp[GPU-0] -t 2>/dev/null)

DEFAULT="\e[0m"
RED="\e[0;31m"
GREEN="\e[0;32m"
ORANGE="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"

if [ -n $TEMP ]; then
    if (($TEMP < 40)); then
        echo -ne "$BLUE"
    elif (($TEMP < 45)); then
        echo -ne "$BLUE"
    elif (($TEMP < 50)); then
        echo -ne "$CYAN"
    elif (($TEMP < 55)); then
        echo -ne "$CYAN"
    elif (($TEMP < 60)); then
        echo -ne "$GREEN"
    elif (($TEMP < 65)); then
        echo -ne "$GREEN"
    elif (($TEMP < 70)); then
        echo -ne "$ORANGE"
    elif (($TEMP < 75)); then
        echo -ne "$ORANGE"
    else
        echo -ne "$RED"
    fi
fi

nvidia-smi
