#!/bin/bash

# Ensure dialog lib is installed
pacman -S --noconfirm dialog
# Ensure dosfstools is installed to have mkfs.vfat library
pacman -S --noconfirm dosfstools
  
devicelist=$(lsblk -dplnx size -o name,size | grep -Ev "boot|rpmb|loop" | tac)
device=$(dialog --stdout --menu "Select installation disk" 0 0 0 ${devicelist}) || exit 1

sgdisk --zap-all $device

fdisk $device --wipe never <<EOF
o # clear the in memory partition table
g # GPT label
# Partition 1 creation start
n # Create new partition (/dev/sda1) / (/boot) / number 1 / starting from the beginning of disk / +500MB of space
1
 
+500M
# Partition 1 creation end
# Partition 2 creation start
n # Create new partition (/dev/sda2) / (SWAP) / number 2 / starting from the beginning of disk / +16000MB of space
2
 
+16G
t # set custom type for partition 2 (type 19 - SWAP)
2
19
# Partition 2 creation end
# Partition 3 creation start
n # Create new partition (/dev/sda3) / (/) / number 3 / starting from the beginning of disk / +100GB of space
3
 
+100G
# Partition 3 creation end
# Partition 4 creation start
n # Create new partition (/dev/sda4) / (/home) / number 4 / starting from the beginning of disk / +700GB of space
4
 
+700G
# Partition 4 creation end
# Partition 5 creation start
n # Create new partition (/dev/sda5) / (/var) / number 5 / starting from the beginning of disk / rest of available space for this partition
5
 
 
# Partition 5 creation end
  
p # show partitions list
q # leave
EOF

# Build filesystems for partitions
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4
mkfs.ext4 /dev/sda5

# Initialize SWAP
mkswap /dev/sda2
swapon /dev/sda2

# Mount filesystem
mount /dev/sda3 /mnt
mkdir /mnt/home
mkdir /mnt/var
mount /dev/sda4 /mnt/home
mount /dev/sda5 /mnt/var
