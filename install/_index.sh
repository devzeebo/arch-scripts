#!/bin/bash
export ARCH_INSTALL_SCRIPTS_VERSION=0.0.26

get_script_from() {
    echo "Downloading $2..."

    curl -s "https://cdn.jsdelivr.net/gh/$1" --output $2
    chmod +x $2
}

get_script() {
    get_script_from "devzeebo/arch-scripts@${ARCH_INSTALL_SCRIPTS_VERSION}/install/$1" $1
}

run_script() {

    local should_run
    read -p "Run $2? [y,n] " should_run

    echo
    echo

    if [[ "$should_run" == "y" ]]; then
        echo "Running $2"
        source $1
    else
        echo "Skipping $2"
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

    get_script pick-timezone.sh
    get_script localization.sh

    run_script pick-timezone.sh 'Pick Timezone'
    run_script localization.sh 'Set Locale'
fi
