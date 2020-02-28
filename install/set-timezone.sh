#!/bin/bash

ln -sf "/usr/share/zoneinfo/$1" /etc/localtime

hsclock --systohc