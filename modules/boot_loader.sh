# Change root into new system
arch-chroot /mnt << EOCHR

# Install boot loader
pacman -S --noconfirm grub efibootmgr

# Mount bootable partition
mkdir /boot/efi
mount /dev/sda1 /boot/efi

# Setup boot loader
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi

# Generate boot loader configuration
grub-mkconfig -o /boot/grub/grub.cfg

EOCHR
