#!/bin/bash

DIR=$(dirname ${BASH_SOURCE[0]})
PULSE_CONFIG_DIR=/etc/pulse
PULSE_DEFAULT_FILE=${PULSE_CONFIG_DIR}/default.pa
BACKUP_FILE=${PULSE_CONFIG_DIR}/default.pa.bak


function main() {
    backupPulseDefault
    modifyPulseDefault
}

function backupPulseDefault() {
    info "BACKING UP FILE - ${PULSE_DEFAULT_FILE}"
    if [[ ! -f ${PULSE_DEFAULT_FILE} ]]; then
        error "FILE DOES NOT EXIST - ${PULSE_DEFAULT_FILE}"
        exit 1
    fi

    if [[ -f ${BACKUP_FILE} ]]; then
        info "BACKUP ALREADY EXISTS - ${BACKUP_FILE}"
        return 0
    else
        cp -v ${PULSE_DEFAULT_FILE} ${BACKUP_FILE}
        if [[ ! -f ${BACKUP_FILE} ]]; then
            error "FILE NOT BACKED UP - ${PULSE_DEFAULT_FILE}"
            info "EXITING"
            exit 1
        fi
    fi
}

function modifyPulseDefault() {
    disableSuspendOnIdle
    info "MODIFICATION COMPLETE: $(diff ${BACKUP_FILE} ${PULSE_DEFAULT_FILE})"
}

function disableSuspendOnIdle() {
    info "DISABLING SUSPEND-ON-IDLE"
    sed -i "s/^\(load-module module-suspend-on-idle.*\)/#\1/" ${PULSE_DEFAULT_FILE}
}

## OUTPUT FUNCTIONS
# https://google.github.io/styleguide/shell.xml#STDOUT_vs_STDERR
RED="\033[0;31m"
RED_BOLD="\033[1;31m"
YELLOW="\033[0;33m"
YELLOW_BOLD="\033[1;33m"
PLAIN="\033[0m"
PLAIN_BOLD="\033[1m"

function error() {
    echo -e "${RED_BOLD}[$(date +'%Y-%m-%dT%H:%M:%S%z')] - ERROR:${RED} $@${PLAIN}" >&2
}

function info() {
    echo -e "${PLAIN_BOLD}[$(date +'%Y-%m-%dT%H:%M:%S%z')] - INFO: ${PLAIN} $@" >&1
}

function warn() {
    echo -e "${YELLOW_BOLD}[$(date +'%Y-%m-%dT%H:%M:%S%z')] - WARN: ${YELLO} $@${PLAIN}" >&1
}

main
