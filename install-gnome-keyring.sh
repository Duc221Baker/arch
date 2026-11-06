#!/bin/bash

set -e

sudo pacman -S --needed gnome-keyring libsecret seahorse

if ! grep -q "pam_gnome_keyring.so" /etc/pam.d/greetd; then
    sudo tee -a /etc/pam.d/greetd > /dev/null <<'EOF'
auth       optional     pam_gnome_keyring.so
session    optional     pam_gnome_keyring.so auto_start
EOF
fi

echo "Success. Please reboot to apply changes."
