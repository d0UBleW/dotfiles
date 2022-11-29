#!/bin/bash


function battery_meter() {

    if [ "$(which acpi)" ]; then

        # Set the default color to the local variable fgdefault.
        local fgdefault='#[default]'

        # Check for existence of a battery.
        if [ -x /sys/class/power_supply/BAT1 ] ; then

            local batt0=$(acpi -b 2> /dev/null | awk '/Battery 0/{print $4}' | cut -d, -f1)

            case $batt0 in

                # From 100% to 75% display color grey.
                100%|9[0-9]%|8[0-9]%|7[5-9]%)
                fgcolor='#[fg=blue]' 
                icon=' '
                    ;;

                # From 74% to 50% display color green.
                7[0-4]%|6[0-9]%|5[0-9]%)
                fgcolor='#[fg=green]' 
                icon=' '
                    ;;

                # From 49% to 25% display color yellow.
                4[0-9]%|3[0-9]%|2[5-9]%)
                fgcolor='#[fg=yellow]' 
                icon=' '
                    ;;

                # From 24% to 0% display color red.
                2[0-4]%|1[0-9]%|[0-9]%)
                fgcolor='#[fg=red]'
                icon=' '
                    ;;
            esac

            if [ "$(cat /sys/class/power_supply/AC1/online)" == 1 ] ; then
                icon=' ' 
            fi

            # Display the percentage of charge the battery has.
            printf "%s " "${fgcolor}${icon}${batt0}${fgdefault}"

        fi


    fi
}

function load_average() {
    printf "%s " "$(uptime | awk -F: '{printf $NF}' | tr -d ',')"

}

function date_time() {
    # printf "%s" "$(date +'%Y-%m-%d %H:%M:%S %Z')"
    printf "%s" "$(date +'%c')"

    # printf "%s" "%a, %l:%M:%S %p#[default] #[fg=blue]%Y-%m-%d #[fg=default]"
}

function ipv4() {
    printf "🌐 #[fg=green]%s#[default]" "$(ip address show eth0 | grep -oP '(?<=inet ).*(?= brd)')"
}

function sep() {
    printf " | "
}

function main() {
    ipv4
    sep
    date_time
    sep
    battery_meter
}

# Calling the main function which will call the other functions.
main
