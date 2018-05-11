#!/bin/bash

DIR=$(dirname ${BASH_SOURCE[0]})
RESTART_ON_RESUME_FILE=90-fancontrol.sleep

sudo dnf install lm_sensors
sudo cp ${DIR}/fancontrol /etc/fancontrol

# sudo cp 90-fancontrol.sleep /lib/systemd/system-sleep/90-fancontrol.sleep
sudo cp ${DIR}/${RESTART_ON_RESUME_FILE} /lib/systemd/system-sleep/${RESTART_ON_RESUME_FILE}

sudo systemctl enable fancontrol
sudo systemctl start fancontrol
