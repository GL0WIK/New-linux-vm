#!/bin/bash

# Check if both hostname and IP address are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <hostname> <ip_address>"
    exit 1
fi

hostname="$1"
ip_addr="$2"

# Update and upgrade the system packages
apt update && apt upgrade -y

# Set hostname and update related configuration files
echo "$hostname" > /etc/hostname
sed -i "s/template-ubuntu/$hostname/g" /etc/hosts

# Restart hostname service
systemctl restart systemd-hostnamed

# Renew DHCP lease
dhclient

# Clone the repository
git clone https://github.com/GL0WIK/New-linux-vm.git
cd New-linux-vm

# Configure network settings
gateway=$(echo "$ip_addr" | cut -d '.' -f 1-3)".1"
echo "Gateway: $gateway"
sed -i "s/ip-addr/$ip_addr/g" 00-installer-config.yaml
sed -i "s/gateway/$gateway/g" 00-installer-config.yaml

# Copy modified configuration file to netplans directory
cp 00-installer-config.yaml /etc/netplan/00-installer-config.yaml

# Apply network configuration
netplan apply

echo "Network configuration applied."

# Inform user about completion
echo "Setup completed successfully."
