#!/bin/bash

prompt_part() {
    local __resultVar=$1

    echo '\n\n'
    echo 'Available partitions:'
    echo

    fdisk -l | grep '^/dev'

    echo "Select $2 partition:"

    mapfile -t local options < <( fdisk -l | sed -n 's|^\([/a-z0-9]\+\).*|\1|p' )
    select opt in "${options[@]}"; do
        case $opt in
            /dev*)
                eval $__resultVar="'$opt'"
                break
                ;;
            *)
                echo 'Invalid Option'
                ;;
        esac
    done
}

echo
echo $opt

prompt_part ext4_part 'ext4'

echo "Formatting ext4 partition: $ext4_part"
