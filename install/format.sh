#!/bin/bash

prompt_part() {
    local __resultVar=$1

    echo 
    echo 
    echo 'Available partitions:'
    echo

    fdisk -l | grep '^/dev'

    PS3="Select $2 partition: "
    readarray -t local options < <( fdisk -l | sed -n 's|^\([/a-z0-9]\+\).*|\1|p' )
    select opt in "${options[@]}" "Skip"; do
        case $opt in
            /dev*)
                eval $__resultVar="'$opt'"
                break
                ;;
            Skip)
                eval $__resultVar='Skip'
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

if [[ $ext4_part != "Skip" ]]; then
    echo "Formatting ext4 partition: $ext4_part"

    umount -q $ext4_part
    mkfs.ext4 $ext4_part

    echo "Done formatting $ext4_part"
else
    echo 'Skipping formatting ext4 partition'
fi

prompt_part swap_part 'swap'

if [[ $swap_part != 'Skip' ]]; then

    echo "Setting up swap"

    if [[ -n $(swapon -s) ]]; then
        swapoff $swap_part
    fi
    mkswap $swap_part
    swapon $swap_part
else
    echo 'Skipping creating swap partition'
fi