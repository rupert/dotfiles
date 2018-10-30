#!/bin/bash

set -euo pipefail

function disable_agent() {
    echo "Disabling agent $1 ..."
    launchctl disable "gui/$(id -u)/$1"
}

function disable_daemon() {
    echo "Disabling daemon $1 ..."
    sudo launchctl disable "system/$1"
}

disable_agent com.centrastage.tray
disable_agent com.eset.esets_gui # just the GUI not the daemon
disable_agent com.splashtop.streamer-for-user

disable_daemon com.centrastage.cag
disable_daemon com.splashtop.streamer-daemon
disable_daemon com.splashtop.streamer-srioframebuffer
