#!/usr/bin/env bash

set -e

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

tmux-option() {
    local value=$(tmux show-option -gqv "$1")
    local default="$2"

    if [[ -n $value ]]; then
        echo "$value"
    else
        echo "$default"
    fi
}

kbd_layout_placeholder="\#{kbd_layout}"

main() {
    local status_left=$(tmux-option "status-left")
    local status_right=$(tmux-option "status-right")

    local kbd_layout="#(${HERE}/scripts/keyboard_layout.sh)"

    tmux set-option -g "status-left" "${status_left//$kbd_layout_placeholder/$kbd_layout}"
    tmux set-option -g "status-right" "${status_right//$kbd_layout_placeholder/$kbd_layout}"
}

main
