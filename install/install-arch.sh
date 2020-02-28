#!/bin/bash

pacstrap /mnt base linux linux-firmware git vim

genfstab -U /mnt > /mnt/etc/fstab