export ARCH_INSTALL_SCRIPTS_VERSION=0.0.2

get_script() {
    curl "https://cdn.jsdelivr.net/gh/devzeebo/arch-scripts@${ARCH_INSTALL_SCRIPTS_VERSION}/install/$1" --output $1
    chmod +x $1
}

get_script format.sh
get_script install-arch.sh
get_script pick-timezone.sh

./format.sh
./install-arch.sh

arch-chroot /mnt

./pick-timezone.sh