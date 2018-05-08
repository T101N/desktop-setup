#!/bin/bash

DIR=$(dirname ${BASH_SOURCE[0]})

sudo dnf install lm_sensors
cp ${DIR}/fancontrol /etc/fancontrol
