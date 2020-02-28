#!/bin/bash

read -p 'Enter locale: (en_us.UTF-8)' locale

sed "s|^#\($locale.*\)|\1|g" /etc/locale.gen

echo "LANG=$locale" > /etc/locale.conf