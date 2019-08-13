#!/bin/bash
 
# Check if network is working
if ping -q -c 1 -W 1 google.com >/dev/null; then
 echo "You are connected to the network."
else
 echo "You are not connected to the network! Please do it, for example using 'wifi-menu'"
 exit 1;
fi

# Initialize all needed variables
read -p "Provide hostname: " hostname
: "${hostname:?"Missing hostname"}"
 
read -p "Provide user name: " user_name
: "${user_name:?"Missing user name"}"
 
 
read -p "Provide user password: " user_password
: "${user_password:?"Missing user password"}"
 
read -p "Repeat user password: " user_repeat_password
: "${user_repeat_password:?"Missing user repeat password"}"
 
[[ "$user_password" == "$user_repeat_password" ]] || ( echo "User passwords did not match"; exit 1; )
 
read -p "Root password: " root_password
: "${root_password:?"Missing root password"}"
 
read -p "Repeat root password: " root_repeat_password
: "${root_repeat_password:?"Missing root repeat password"}"
 
[[ "$root_password" == "$root_repeat_password" ]] || ( echo "User passwords did not match"; exit 1; )

echo "Install fun pack? (Nvidia drivers, Nvidia Optimus, Steam)"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) export INSTALL_FUN_PACK=true; break;;
        No ) export INSTALL_FUN_PACK=false; break;;
    esac
done
 
# Export all install variables

export INSTALL_HOSTNAME=$hostname
export INSTALL_USER_NAME=$user_name
export INSTALL_USER_PASSWORD=$user_password
export INSTALL_ROOT_PASSWORD=$root_password
 
./modules/system_clock.sh
./modules/partitions.sh
./modules/setup_and_configure_system.sh

