#!/bin/bash

read -p 'Enter locale: (en_us.UTF-8)' locale

if [[ -z $locale ]]; then
    local='en_us.UTF-8'
fi

sed -i "s|^#\($locale.*\)|\1|g" /etc/locale.gen

echo "LANG=$locale" > /etc/locale.conf