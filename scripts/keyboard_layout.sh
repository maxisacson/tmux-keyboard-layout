#!/usr/bin/env bash

set -e

try_gsettings() {
    if [[ -z $(which gsettings) ]]; then
        return
    fi

    if [[ -z $(gsettings list-schemas | grep org.gnome.desktop.input-sources) ]]; then
        return
    fi

    if [[ -z $(gsettings list-keys org.gnome.desktop.input-sources | grep mru-sources) ]]; then
        return
    fi

    local layout=$(gsettings get org.gnome.desktop.input-sources mru-sources | cut -d "'" -f 4)

    if [[ -z $layout ]]; then
        return
    fi

    echo "$layout"

    exit
}

try_default() {
    echo "??"
}

try_gsettings
try_default
