#!/bin/bash
 
# Check if network is working
if ping -q -c 1 -W 1 google.com >/dev/null; then
 echo "You are connected to the network."
else
 echo "You are not connected to the network! Please do it, for example using 'wifi-menu'"
 exit 1;
fi

# Initialize all needed variables
echo -n "Provide hostname: "
read hostname
: "${hostname:?"Missing hostname"}"
 
echo -n "Provide user name: "
read user_name
: "${user_name:?"Missing user name"}"
 
echo -n "Provide user password: "
read -s user_password
: "${user_password:?"Missing user password"}"

echo -n "Repeat user password: "
read -s user_repeat_password
: "${user_repeat_password:?"Missing user repeat password"}"
 
[[ "$user_password" == "$user_repeat_password" ]] || ( echo "User passwords did not match"; exit 1; )
 
echo -n "Root password: "
read -s root_password
: "${root_password:?"Missing root password"}"
 
echo -n "Repeat root password: "
read -s root_repeat_password
: "${root_repeat_password:?"Missing root repeat password"}"
 
[[ "$root_password" == "$root_repeat_password" ]] || ( echo "User passwords did not match"; exit 1; )

# Export all install variables

export INSTALL_HOSTNAME=$hostname
export INSTALL_USER_NAME=$user_name
export INSTALL_USER_PASSWORD=$user_password
export INSTALL_ROOT_PASSWORD=$root_password
 
./modules/system_clock.sh
./modules/partitions.sh
./modules/setup_and_configure_system.sh
./modules/boot_loader.sh
./modules/install_software.sh
./modules/setup_users.sh

reboot
