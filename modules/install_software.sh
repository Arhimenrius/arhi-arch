#!/bin/bash

# Change root into new system
arch-chroot /mnt << EOCHR

# Enable 32-bit software and libraries
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# Upgrade packages
pacman -Syu

# Install packages
pacman -S --noconfirm \
networkmanager \
xorg plasma-meta sddm \
vim kate \
konsole krusader git htop openssh \
chromium firefox \
nvidia lib32-nvidia-utils \
bumblebee bbswitch primus mesa xf86-video-intel lib32-virtualgl lib32-nvidia-utils \
steam


# Enable services
systemctl enable sddm
systemctl enable bumblebee
systemctl enable sshd

# Configure GIT
git config --global user.name "Andrzej Wojtys"
git config --global user.email "arhimenrius@gmail.com"

# Inject rest of configuration
installer_dir=`dirname $(realpath $0)`
cp ${installer_dir}/configs/home/* /home/${INSTALL_USER_NAME}

EOCHR
