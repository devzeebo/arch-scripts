#!/bin/bash

pick_timezone() {
    read -e -p 'Enter a timezone: (US/Central): ' timezone

    if [[ -z $timezone ]]; then
        timezone='US/Central'
    fi
}

pick_timezone_complete() {
    for zone in $( find /usr/share/zoneinfo -type f | grep -v '^/usr/share/zoneinfo/[a-z]\+' | sed -n 's|/usr/share/zoneinfo/\(.*\)|\1|p' | sort ); do
        COMREPLY+=( $zone )
    done
}
complete -F pick_timezone_complete pick_timezone

pick_timezone

ln -sf "/usr/share/zoneinfo/$timezone" /etc/localtime

hsclock --systohc