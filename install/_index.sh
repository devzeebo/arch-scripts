export ARCH_INSTALL_SCRIPTS_VERSION=0.0.4

get_script() {
    curl "https://cdn.jsdelivr.net/gh/devzeebo/arch-scripts@${ARCH_INSTALL_SCRIPTS_VERSION}/install/$1" --output $1
    chmod +x $1
}

run_script() {
    echo "Run $2? [yN]"

    local response

    read $response

    if [[ $response == "y" ]]; then
        $($1)
    fi
}

get_script format.sh
get_script install-arch.sh
get_script pick-timezone.sh

run_script ./format.sh 'Format'
run_script ./install-arch.sh 'Install Arch'

arch-chroot /mnt

run_script ./pick-timezone.sh 'Select Timezone'