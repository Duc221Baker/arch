#!/bin/bash

set -e

# File manager
sudo pacman -S --needed dolphin ark 7zip unrar

# Text Editor & Dev
sudo pacman -S --needed kate
yay -S --needed visual-studio-code-bin postman-bin

# Docker
sudo pacman -S docker docker-compose
sudo usermod -aG docker $USER

# Password Manager
sudo pacman -S --needed bitwarden

# Browser
sudo pacman -S --needed firefox librewolf
yay -S --needed ungoogled-chromium-bin

# Discord
yay -S --needed vesktop-bin

# Telegram
sudo pacman -S --needed telegram-desktop

# qBittorrent
sudo pacman -S --needed qbittorrent

# Multimedia
sudo pacman -S --needed haruna gwenview imagemagick

# Flatpak
sudo pacman -S --needed flatpak

# Ebook
sudo pacman -S --needed foliate

# Audio Controller
sudo pacman -S --needed pavucontrol

echo "Success."
