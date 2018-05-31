#!/bin/bash
DIR=$(dirname ${BASH_SOURCE[0]})
declare -r GRUB_FILE=/etc/default/grub
declare -ri GRUB_TIMEOUT=1

if [[ ! -f ${GRUB_FILE} ]]; then
    echo "${GRUB_FILE} not found" >&2
    exit 1
fi

function main() {
    sed -i "s/^\(GRUB_TIMEOUT=\).*/\1${GRUB_TIMEOUT}/" ${GRUB_FILE}
}

main
