#!/bin/bash

set -e

sudo pacman -S --needed git base-devel

git clone https://aur.archlinux.org/yay-bin.git

cd yay-bin

makepkg -si

echo "Success."
