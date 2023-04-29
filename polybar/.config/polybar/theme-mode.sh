#!/usr/bin/env bash

THEME_MODE=$(cat $HOME/.theme)
[[ "$THEME_MODE" == "light" ]] && echo "    " || echo "    "
