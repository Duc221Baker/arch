
#!/bin/bash

set -e

mkdir -p ~/.config

cat >> ~/.config/kdeglobals <<'EOF'

[General]
TerminalApplication=kitty
TerminalManager=kitty
EOF

# Installing archlinux-xdg-menu
sudo pacman -S --needed --noconfirm archlinux-xdg-menu

# Updating desktop database
sudo update-desktop-database

# Setting up application menu
mkdir -p ~/.config/menus
cp /etc/xdg/menus/arch-applications.menu ~/.config/menus/applications.menu

# Creating pacman hook
sudo mkdir -p /etc/pacman.d/hooks

sudo tee /etc/pacman.d/hooks/kservice.hook > /dev/null <<'EOF'
[Trigger]
Type = Path
Operation = Install
Operation = Upgrade
Operation = Remove
Target = usr/share/applications/*.desktop

[Action]
Description = Rebuilding KDE service cache...
When = PostTransaction
Exec = /usr/bin/sh -c 'XDG_MENU_PREFIX=arch- /usr/bin/kbuildsycoca6 --noincremental'
EOF

echo
echo "Setup completed!"
echo "Please add the following command to your Wayland compositor startup config:"
echo
echo "XDG_MENU_PREFIX=arch- kbuildsycoca6"
