#!/bin/bash
set -e

declare -r DIR=$(dirname ${BASH_SOURCE[0]})
declare INSTALL_DIRECTORY=/opt

declare -ar VALID_OPTIONS=(\
  "--auto"             "Automatically download and install dependencies." \
  "--skip-download"    "Skip downloading the gitkraken archive." \
  "--skip-desktop"    "Skip creating launcher shortcut." \
  "--skip-linking"     "Skip creating symlinks for libraries." \
  "--skip-dependencies"  "Skip installing dependencies" \
)
declare -r OPTIONS_LENGTH=${#VALID_OPTIONS[@]}

## CONSOLE TEXT COLORS
declare -r RED="\033[0;31m"
declare -r RED_BOLD="\033[1;31m"
declare -r YELLOW="\033[0;33m"
declare -r YELLOW_BOLD="\033[1;33m"
declare -r PLAIN="\033[0m"
declare -r PLAIN_BOLD="\033[1m"


function main() {
    if [[ $@ = *"--help"* ]]; then
        printValidOptions   
        exit 0
    fi

    if [[ $@ = *"--auto"* ]]; then
        downloadGitKraken --auto
        setupDesktopFile --auto
        installDependencies --auto
        linkLibraries --auto
        exit 0
    fi

    if [[ ! $@ = *"--skip-download"* ]]; then
        downloadGitKraken
    fi

    if [[ ! $@ = *"--skip-desktop"* ]]; then
        setupDesktopFile
    fi

    if [[ ! $@ = *"--skip-dependencies"* ]]; then
        installDependencies
    fi

    if [[ ! $@ = *"--skip-linking"* ]]; then
        linkLibraries
    fi
}

function downloadGitKraken() {
    declare -r GIT_KRAKEN_URL="https://release.gitkraken.com/linux/gitkraken-amd64.tar.gz"

    if [[ ${1} = "--auto" ]]; then
        declare -r option="yes"
    else
        declare -r option=$(promptYesNo "Download gitkraken archive (yes/no)[default: no]? " "no")
    fi

    case "$(toLower ${option})" in
        "yes")
            info "Downloading gitkraken ..."
            curl --silent --location ${GIT_KRAKEN_URL} | tar -xvzf - -C ${INSTALL_DIRECTORY}/
            ;;
        "no")
            info "Skipping download."
            ;;
    esac
}

function setupDesktopFile() {
    declare -r APPLICATION_DIRECTORY=/usr/share/applications
    declare -r DESKTOP_TARGET=${INSTALL_DIRECTORY}/gitkraken/gitkraken.desktop
    declare -r LINK_LOCATION=${APPLICATION_DIRECTORY}/gitkraken.desktop
    if [[ ${1} = "--auto" ]]; then
        declare -r option="yes"
    else
        declare -r option=$(promptYesNo "Set up shortcut in appliction launcher (yes/no)[default: no]? " "no")
    fi

    case "$(toLower ${option})" in
        "yes")
            info "Creating shortcut in "
            cp ${DIR}/gitkraken.desktop ${DESKTOP_TARGET}
            ln -s ${DESKTOP_TARGET} ${LINK_LOCATION}
            ;;
        "no")
            info "Skipping shortcut creation."
            ;;
    esac
}

function installDependencies() { 
    if [[ ${1} = "--auto" ]]; then
        declare -r option="yes"
    else
        declare -r option=$(promptYesNo "Install dependencies (yes/no)[default: no]? " "no")
    fi
    
    case "$(toLower ${option})" in
        "yes")
            info "Installing dependencies ..."
            dnf install libXScrnSaver
            ;;
        "no")
            info "Skipping dependencies."
            ;;
    esac
}

function linkLibraries() {
    if [[ ${1} = "--auto" ]]; then
        declare -r option="yes"
    else
        declare -r option=$(promptYesNo "Link libraries (yes/no)[default: no]? " "no")
    fi
    
    case "$(toLower ${option})" in
        "yes")
            info "Installing dependencies ..." 
            ln -s /usr/lib64/libcurl.so.4 /usr/lib64/libcurl-gnutls.so.4
            ;;
        "no")
            info "No links created."
            ;;
    esac
}

## promptYesNo message default
# args:
#    message: the message to display to user#    
#    default: A default value if user enters nothing
#
# Exit non-zero if second argument is not "yes" or "no" 
function promptYesNo() {
    if [ -n "${2}" ]; then
        if [[ ! ${2} = "yes" ]] && [[ ! ${2} = "no" ]]; then
            error "INVALID USE OF FUNCTION: ${FUNCNAME[0]}"
            error "Use \"yes\" or \"no\" instead of \"$2\" for default"
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

function printValidOptions() {
    echo -e "${PLAIN_BOLD}List of available options:${PLAIN}"
    printf "%20s\t%s\n" 
    for (( i=0; i<${OPTIONS_LENGTH}; i=$(($i+2)) )); do
        printf "%20s\t%s\n" "${VALID_OPTIONS[${i}]}" "${VALID_OPTIONS[($i + 1)]}"
    done
}

## OUTPUT FUNCTIONS
# https://google.github.io/styleguide/shell.xml#STDOUT_vs_STDERR
function error() {
    echo -e "${RED_BOLD}[$(date +'%Y-%m-%dT%H:%M:%S%z')] - ERROR:${RED} $@${PLAIN}" >&2
}

function info() {
    echo -e "${PLAIN_BOLD}[$(date +'%Y-%m-%dT%H:%M:%S%z')] - INFO: ${PLAIN} $@" >&1
}

function warn() {
    echo -e "${YELLOW_BOLD}[$(date +'%Y-%m-%dT%H:%M:%S%z')] - WARN: ${YELLO} $@${PLAIN}" >&1
}

main $@
