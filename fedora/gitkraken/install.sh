#!/bin/bash
set -e
source ../utilities/bash/common.sh

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
            log "info" "Downloading gitkraken ..."
            curl --silent --location ${GIT_KRAKEN_URL} | tar -xvzf - -C ${INSTALL_DIRECTORY}/
            ;;
        "no")
            log "info" "Skipping download."
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
            log "info" "Creating shortcut in "
            cp ${DIR}/gitkraken.desktop ${DESKTOP_TARGET}
            ln -s ${DESKTOP_TARGET} ${LINK_LOCATION}
            ;;
        "no")
            log "info" "Skipping shortcut creation."
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
            log "info" "Installing dependencies ..."
            dnf install libXScrnSaver
            ;;
        "no")
            log "info" "Skipping dependencies."
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
            log "info" "Installing dependencies ..." 
            ln -s /usr/lib64/libcurl.so.4 /usr/lib64/libcurl-gnutls.so.4
            ;;
        "no")
            log "info" "No links created."
            ;;
    esac
}

function printValidOptions() {
    echo -e "${PLAIN_BOLD}List of available options:${PLAIN}"
    printf "%20s\t%s\n" 
    for (( i=0; i<${OPTIONS_LENGTH}; i=$(($i+2)) )); do
        printf "%20s\t%s\n" "${VALID_OPTIONS[${i}]}" "${VALID_OPTIONS[($i + 1)]}"
    done
}

main $@
