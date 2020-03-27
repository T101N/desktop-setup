#!/bin/bash

DIR=$(dirname ${BASH_SOURCE[0]})
GRUB_DIR=/etc/default
GRUB_FILE=${GRUB_DIR}/grub
BACKUP_FILE=${GRUB_DIR}/grub.bak
GRUB_CFG=/boot/efi/EFI/fedora/grub.cfg

function main() {
    if [[ ! -f ${GRUB_FILE} ]]; then
        error "FILE DOES NOT EXIST - ${GRUB_FILE}"
        exit 1
    fi

    backupGrub
    setTimeout 1
    setAcpiEnforceResources lax
    updateGrub ${GRUB_CFG}
}

function updateGrub() {
    if [ ! -f ${1} ]; then
        error "FILE DOES NOT EXIST - ${1}"
        exit 1
    fi
    grub2-mkconfig -o ${1}
}

function setTimeout() {
    info "Setting GRUB_TIMEOUT=${1}"
    sed -i "s/^\(GRUB_TIMEOUT=\).*/\1${1}/" ${GRUB_FILE}
}

function setAcpiEnforceResources() {
    info "Setting acpi_enforce_resources"
    source ${GRUB_FILE}
    if [ -n "${GRUB_CMDLINE_LINUX}" ]; then
        if [[ "${GRUB_CMDLINE_LINUX}" = *"acpi_enforce_resources="* ]]; then
            info "acpi_enforce_resources found"
            info "acpi_enforce_resources not changed"
            exit 0
        else
            info "acpi_enforce_resources not found"
            info "adding acpi_enforce_resources=lax to GRUB_CMDLINE_LINUX"
            sed -i "s/^\(GRUB_CMDLINE_LINUX=\"\)/\1acpi_enforce_resources=${1} /" ${GRUB_FILE}
        fi
    fi
}

function backupGrub() {
    info "BACKING UP FILE - ${GRUB_FILE}"
    if [[ -f ${BACKUP_FILE} ]]; then
        info "BACKUP ALREADY EXISTS - ${BACKUP_FILE}"
        return 0
    else
        cp -v ${GRUB_FILE} ${BACKUP_FILE}
        if [[ ! -f ${BACKUP_FILE} ]]; then
            error "FILE NOT BACKED UP - ${GRUB_FILE}"
            info "EXITING"
            exit 1
        fi
    fi
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
