#!/usr/bin/env bash

if ! command -v rofi 2>/dev/null ; then
    echo "Error: Requirement rofi not found in your PATH." >&2
    exit 1
fi

exec rofi "$@"
