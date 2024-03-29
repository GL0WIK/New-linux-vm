#!/bin/bash
ip_addr="$1"

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