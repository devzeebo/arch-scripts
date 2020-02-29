#!/bin/bash
read -p 'Enter locale: (en_US.UTF-8)' locale

if [[ -z $locale ]]; then
    locale='en_US.UTF-8'
fi

echo "s|^#\($locale.*\)$|\1|"
sed -i "s|^#\($locale.*\)$|\1|" /etc/locale.gen

echo "LANG=$locale" > /etc/locale.conf