#!/bin/bash

function ipv4() {
    printf "#[fg=yellow]%s#[default]" "$(ip address show eth0 | grep -oP '(?<=inet ).*(?= brd)')"
}

function sep() {
    printf " | "
}

function session_name() {
    printf "#[fg=green]#S #[default]> "
}

function main() {
    session_name
}

# Calling the main function which will call the other functions.
main
