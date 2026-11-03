#!/bin/bash

set -e

# Enable multilib
sudo sed -i '/^#\[multilib\]/,/^#Include = \/etc\/pacman.d\/mirrorlist/ {
    s/^#\[multilib\]/[multilib]/
    s/^#Include =/Include =/
}' /etc/pacman.conf

# Update system
sudo pacman -Syu --noconfirm

# Install graphics and media libraries
sudo pacman -S --needed --noconfirm \
    vulkan-intel \
    lib32-vulkan-intel \
    intel-media-driver \
    libva-utils

