#!/bin/bash
DIR=$(dirname ${BASH_SOURCE[0]})

nvidia-settings -a "[gpu:0]/GPUFanControlState=1"

setFanSpeed() {
    nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=$1"
}

# while true; do
TEMP=$(nvidia-settings -q [gpu:0]/GPUCoreTemp[GPU-0] -t 2>/dev/null)
if [ -n $TEMP ]; then
    if (($TEMP < 40)); then
        setFanSpeed "10"
    elif (($TEMP < 45)); then
        setFanSpeed "15"     
    elif (($TEMP < 50)); then
        setFanSpeed "20"
    elif (($TEMP < 55)); then
        setFanSpeed "25"
    elif (($TEMP < 60)); then
        setFanSpeed "35"
    elif (($TEMP < 65)); then
        setFanSpeed "45"
    elif (($TEMP < 70)); then
        setFanSpeed "50"
    elif (($TEMP < 75)); then
        setFanSpeed "60"
    else
        setFanSpeed "80"
    fi
fi
    # sleep 2
# done