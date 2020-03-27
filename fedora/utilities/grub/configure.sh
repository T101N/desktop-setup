#!/bin/bash

DIR=$(dirname ${BASH_SOURCE[0]})

declare -r GRUB_DIR=/etc/default
declare -r GRUB_FILE=${GRUB_DIR}/grub
declare -r GRUB_BACKUP=${GRUB_DIR}/grub.[$(date +'%Y-%m-%dT%H:%M:%S')].bak
declare -r GRUB_CFG=/boot/efi/EFI/fedora/grub.cfg

function main() {
    if [[ ! -f ${GRUB_FILE} ]]; then
        error "FILE DOES NOT EXIST - ${GRUB_FILE}"
        exit 1
    fi

    backupGrub
    setTimeout 1
    addGrubCmdValue clearcpuid=514
    updateGrub
}

function addGrubCmdValue() {
    info "Adding to GRUB_CMDLINE_LINUX - ${1}"
    if [[ ${#1} -ge 1 ]]; then
        declare -r local result=$(grep "^\(GRUB_CMDLINE_LINUX=\".*\)\(${1}\)" ${GRUB_FILE})

        if [ ${#result} -gt 0 ]; then
            warn "Value (${1}) already exists"
            warn "Skipping step"
            exit 1
        else
            sed -i "s/^\(GRUB_CMDLINE_LINUX=\"\)/\1${1} /" ${GRUB_FILE}
        fi
    else
        error "Value length insufficient"
    fi
}

function removeGrubCmdValue() {
    info "Removing value from GRUB_CMDLINE_LINUX - ${1}"
    if [[ ${#1} -ge 1 ]]; then
        sed -i "s/^\(GRUB_CMDLINE_LINUX=\".*\)\(${1}=[^\s]* \)/\1/"  ${GRUB_FILE}
    else
        error "Value length insufficient"
    fi
}

function setTimeout() {
    info "Setting GRUB_TIMEOUT=${1}"
    sed -i "s/^\(GRUB_TIMEOUT=\).*/\1${1}/" ${GRUB_FILE}
}

function backupGrub() {
    info "BACKING UP FILE - ${GRUB_FILE}"
    if [ -f ${GRUB_BACKUP} ]; then
        info "BACKUP ALREADY EXISTS - ${GRUB_BACKUP}"
        return 0
    else
        cp -v ${GRUB_FILE} ${GRUB_BACKUP}
        if [[ ! -f ${GRUB_BACKUP} ]]; then
            error "FILE NOT BACKED UP - ${GRUB_FILE}"
            info "EXITING"
            exit 1
        fi
    fi
}

function updateGrub() {
    if [ ! -f ${1} ]; then
        error "FILE DOES NOT EXIST - ${1}"
        exit 1
    fi
    grub2-mkconfig -o ${1}
}

## OUTPUT FUNCTIONS
# https://google.github.io/styleguide/shell.xml#STDOUT_vs_STDERR
RED="\033[0;31m"
RED_BOLD="\033[1;31m"
YELLOW="\033[0;33m"
YELLOW_BOLD="\033[1;33m"
PLAIN="\033[0m"
PLAIN_BOLD="\033[1m"

DATE_FORMAT="%Y-%m-%dT%H:%M:%S%z"

function error() {
    echo -e "${RED_BOLD}[$(date +${DATE_FORMAT})] - ERROR > ${RED} $@${PLAIN}" >&2
}

function info() {
    echo -e "${PLAIN_BOLD}[$(date +${DATE_FORMAT})] - INFO > ${PLAIN} $@" >&1
}

function warn() {
    echo -e "${YELLOW_BOLD}[$(date +${DATE_FORMAT})] - WARN > ${YELLO} $@${PLAIN}" >&1
}

main
