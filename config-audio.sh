#!/bin/bash

set -e

sudo pacman -S --needed pipewire-pulse rtkit

systemctl --user enable --now pipewire-pulse
sudo systemctl enable --now rtkit-daemon

echo "Success."
