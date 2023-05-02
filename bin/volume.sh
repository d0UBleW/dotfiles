#!/usr/bin/env bash

THEME_MODE=$(cat ~/.theme | sed 's/[^ ]\+/\L\u&/g')
ICON_DIR="/usr/share/icons/Papirus-${THEME_MODE}/16x16/actions"

function get_icon {
    echo "${ICON_DIR}/${1}.svg"
}

function notify {
    volume=$(pamixer --get-volume)
    muted=$(pamixer --get-mute)
    if [[ "$volume" -eq 0 ]] || [[ "$muted" == "true" ]]; then
        level=muted
    elif [[ "$volume" -lt 33 ]]; then
        level=low
    elif [[ "$volume" -lt 66 ]]; then
        level=medium
    else
        level=high
    fi

    icon=$(get_icon "audio-volume-${level}")
    notify-send \
        -e \
        -h int:value:${volume} \
        -i ${icon} \
        -u low \
        -t 2000 \
        -r 9999 \
        "Volume: ${volume}%"
}

case "$1" in
    up)
        pamixer -i "${2:-1}"
        notify
        ;;

    down)
        pamixer -d "${2:-1}"
        notify
        ;;

    mute)
        pamixer -t
        notify
        ;;
esac
