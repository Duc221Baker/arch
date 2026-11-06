#!/bin/bash

set -e

sudo pacman -S --needed git base-devel

cd ~

git clone https://aur.archlinux.org/yay-bin.git

cd yay-bin

makepkg -si

echo "Success."
