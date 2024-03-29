#!/bin/bash
ip_addr="$2"

apt update && apt upgrade -y

hostname "$1"
chmod 777 /etc/hostname /etc/hosts
sed "s/template-ubuntu/$1/g" /etc/hosts > /home/user/hosts.out
rm /etc/hosts
mv /home/user/hosts.out /etc/hosts
echo "$1" > /etc/hostname
chmod 644 /etc/hostname /etc/hosts
service hostname down
service hostname start
dhclient


git --config
git --config

git clone https://github.com/GL0WIK/New-linux-vm.git

cd New-linux-vm

three_numbers=$(echo $ip_addr | cut -d '.' -f 1-3)

gateway="$three_numbers.1"

echo "Adresse IP modifiée : $gateway"

while IFS= read -r line; do
    modified_line="${line//ip-addr/$ip_addr}"
    modified_line="${modified_line//gateway/$gateway}"
    echo "$modified_line"
done < "00-installer-config.yaml" > temp.yaml

# Remplacer le fichier original par le fichier temporaire
mv temp.yaml /etc/netplans/00-installer-config.yaml

echo "Le fichier ici.yaml a été mis à jour avec les modifications."