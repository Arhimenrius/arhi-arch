#!/bin/bash

# Change root into new system
arch-chroot /mnt << EOCHR

# Create user
useradd -m $INSTALL_USER_NAME

# Change user's password
passwd $INSTALL_USER_NAME << EOF
$INSTALL_USER_PASSWORD
$INSTALL_USER_PASSWORD
EOF

# Add user to groups
usermod -aG audio,video,optical,storage,bumblebee $INSTALL_USER_NAME

# Change root's password
passwd << EOF
$INSTALL_ROOT_PASSWORD
$INSTALL_ROOT_PASSWORD
EOF

EOCHR
