#!/bin/bash

read -p 'Enter timezone: (US/Central) ' timezone

if [[ -z $timezone ]]; then
    $timezone = 'US/Central'
fi

ln -sf "/usr/share/zoneinfo/$1" /etc/localtime

hsclock --systohc