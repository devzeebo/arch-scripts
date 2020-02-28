#!/bin/bash

read -p 'Enter timezone: (US/Central) ' timezone

if [[ -z $timezone ]]; then
    timezone='US/Central'
fi

ln -sf "/usr/share/zoneinfo/$timezone" /etc/localtime

hwclock --systohc