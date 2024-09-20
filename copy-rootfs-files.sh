#!/bin/bash

# Script parameters
COLOUR_GREEN='\033[0;32m'  # Green colour
COLOUR_NC='\033[0m'        # No colour
SYMBOL_TICK='\xE2\x9C\x94' # Tick symbol
GREEN_TICK="$COLOUR_GREEN$SYMBOL_TICK$COLOUR_NC"

# Configuration parameters
ENV_ROOT="/"
ENV_DESTINATION="/usr/local/"


# Perform copy
copy_file () {
    SOURCE_FILE=$ENV_ROOT$1
    DESTINATION_FILE=$ENV_DESTINATION$1

    cp $SOURCE_FILE $DESTINATION_FILE
    echo -e "[$GREEN_TICK] Copied $SOURCE_FILE to $DESTINATION_FILE"
}

# Copy Network Configurations
copy_configurations_network () {
    echo "Network configurations"
    copy_file etc/network/interfaces
}

# Copy Postfix Configurations
# !!! these configurations are symlinked from /etc/postfix !!!

# Copy Proxmox Configurations
copy_configurations_proxmox () {
    echo "Proxmox configurations"
    copy_file etc/pve/lxc/250.conf
    copy_file etc/pve/lxc/251.conf
    copy_file etc/pve/lxc/254.conf
    copy_file etc/pve/lxc/255.conf

    copy_file etc/pve/qemu-server/200.conf
    copy_file etc/pve/qemu-server/201.conf
    copy_file etc/pve/qemu-server/210.conf
    copy_file etc/pve/qemu-server/301.conf
}

# Copy Samba Configurations
# !!! these configurations are symlinked from /etc/fstab !!!

# Copy systemd Configurations
# !!! these configurations are symlinked from /etc/systemd !!!

# Copy ZFS Configurations
copy_configurations_zfs () {
    echo "ZFS configurations"
    copy_file etc/zfs/zed.d/zed.rc
    copy_file etc/zfs/zed.d/zed.rc.original
}

# Copy fstab Configurations
copy_configurations_fstab () {
    echo "fstab configurations"
    copy_file etc/fstab
}


# Execute the different groups of files to copy
echo "Copying configuration files from $ENV_ROOT to $ENV_DESTINATION"

copy_configurations_network
copy_configurations_proxmox
copy_configurations_zfs
copy_configurations_fstab