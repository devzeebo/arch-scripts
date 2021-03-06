#!/bin/bash
read -p 'Enter locale: (en_US.UTF-8)' locale

if [[ -z $locale ]]; then
    locale='en_US.UTF-8'
fi

sed -i "s|^#\($locale.*\)$|\1|" /etc/locale.gen

locale-gen

echo "LANG=$locale" > /etc/locale.conf