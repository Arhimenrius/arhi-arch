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
konsole krusader git htop openssh ark gwenview dragon \
ffmpeg libvpx x264 \
chromium firefox pepper-flash \
nvidia nvidia-utils lib32-nvidia-utils \
bumblebee bbswitch primus mesa xf86-video-intel lib32-virtualgl vulkan-icd-loader lib32-vulkan-icd-loader lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader \
steam lutris \
wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs

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

# Install AUR packages
su ${INSTALL_USER_NAME}
cd
git clone https://aur.archlinux.org/slack-desktop.git
git clone https://aur.archlinux.org/kazam.git
cd slack-desktop
makepkg -si


EOCHR
