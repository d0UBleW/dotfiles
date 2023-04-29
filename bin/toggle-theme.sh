#!/usr/bin/env bash

THEME_MODE=$(cat $HOME/.theme)

[[ "$THEME_MODE" == "light" ]] && THEME_MODE="dark" || THEME_MODE=light

echo $THEME_MODE > $HOME/.theme

$HOME/bin/mode $(cat $HOME/.theme)
