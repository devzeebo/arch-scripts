#!/bin/bash
export ARCH_INSTALL_SCRIPTS_VERSION=0.0.14

get_script_from() {
    echo "Downloading $2..."

    curl -s "https://cdn.jsdelivr.net/gh/$1" --output $2
    chmod +x $2
}

get_script() {
    get_script_from "devzeebo/arch-scripts@${ARCH_INSTALL_SCRIPTS_VERSION}/install/$1" $1
}

run_script() {
    echo "Run $2? [yN]"

    local response

    read $response

    if [[ $response == "y" ]]; then
        $($1)
    fi
}

if [[ $1 != 'continue' ]]; then
    get_script format.sh
    get_script install-arch.sh
    get_script _continue.sh

    run_script ./format.sh 'Format'
    run_script ./install-arch.sh 'Install Arch'

    cp ./install.sh /mnt
    arch-chroot /mnt ./install.sh 'continue'
else
    mkdir -p setup && cd setup

    get_script set-timezone.sh
    get_script_from 'happy-hacking-linux/timezone-selector@master/timezone-selector.sh' 'timezone-selector'

    chmod -x timezone-selector

    source timezone-selector
    tzSelectionMenu
    ./set-timezone.sh $selected
fi
