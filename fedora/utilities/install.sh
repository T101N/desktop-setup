#!/bin/bash
DIR=$(dirname ${BASH_SOURCE[0]})
DIR_COLORS_256=DIR_COLORS.256color

installTerminal() {
    ${DIR}/tilix/install.sh
    cp ${DIR}/.bashrc ~/.bashrc
}

configureDircolors() {
    sudo cp /etc/${DIR_COLORS_256} /etc/${DIR_COLORS_256}.old
    dircolors -b > /tmp/${DIR_COLORS_256}
    sudo cp /tmp/${DIR_COLORS_256} /etc/${DIR_COLORS_256}
}

installTerminal
configureDircolors
