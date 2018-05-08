#!/bin/bash

## Common variables lie here
declare -g RED=${RED:-"\033[0;31m"}
declare -g RED_BOLD=${RED_BOLD:-"\033[1;31m"}
declare -g YELLOW=${YELLOW:-"\033[0;33m"}
declare -g YELLOW_BOLD=${YELLOW_BOLD:-"\033[1;33m"}
declare -g PLAIN=${PLAIN:-"\033[0m"}
declare -g PLAIN_BOLD=${PLAIN_BOLD:-"\033[1m"}

## promptYesNo message default
# args:
#    message: the message to display to user#    
#    default: A default value if user enters nothing
#
# Exit non-zero if second argument is not "yes" or "no" 
function promptYesNo() {
    if [ -n "${2}" ]; then
        if [[ ! ${2} = "yes" ]] && [[ ! ${2} = "no" ]]; then
            log "error" "INVALID USE OF FUNCTION: ${FUNCNAME[0]}"
            log "error" "Use \"yes\" or \"no\" instead of \"$2\" for default"
            exit 1
        fi
    fi

    while [[ ! ${user_input} = "yes" ]] && [[ ! ${user_input} = "no" ]]; do
        read -p "${1}" user_input
        user_input=${user_input:-"${2}"}
    done

    echo "${user_input}"
}

function toLower() {
    echo "$@" | tr '[:upper:]' '[:lower:]'
}

function toUpper() {
    echo "$@" | tr '[:lower:]' '[:upper:]'
}


## log type message
function log() {
    if [[ ! -n "${2}" ]]; then
        logUsageError "No message supplied."
    fi
    case "${1}" in
        "error")
            echo -e "${RED_BOLD}[$(date +'%Y-%m-%dT%H:%M:%S%z')] - ERROR:${RED} ${2}${PLAIN}" >&2
            ;;
        "info")
            echo -e "${PLAIN_BOLD}[$(date +'%Y-%m-%dT%H:%M:%S%z')] - INFO: ${PLAIN} ${2}" >&1
            ;;
        "warn")
            echo -e "${YELLOW_BOLD}[$(date +'%Y-%m-%dT%H:%M:%S%z')] - WARN: ${YELLO} ${2}${PLAIN}" >&1
            ;;
        *)
            logUsageError "Invalid log type."
            ;; 
    esac
}

function logUsageError() {
    echo -e "${RED_BOLD}INVALID USE OF LOG:${RED} ${1}${PLAIN}" >&2
    exit 1
}
