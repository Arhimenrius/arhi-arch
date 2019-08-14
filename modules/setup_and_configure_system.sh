#!/bin/bash

# Install base system
pacstrap --noconfirm /mnt base base-devel

# Change root into new system
arch-chroot /mnt

# Set timezone
ln -sf cat /usr/share/zoneinfo/Europe/Helsinki /etc/localtime

# Generate /etc/adjtime
hwclock --systohc --utc

# Set locale
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# set network configuration
echo "${INSTALL_HOSTNAME}" > /etc/hostname

echo "127.0.0.1 localhost" > /etc/hosts
echo "::1   localhost" >> /etc/hosts
echo "127.0.1.1 ${INSTALL_HOSTNAME}.localdomain ${INSTALL_HOSTNAME}">> /etc/hosts

# Leave new system root
exit
