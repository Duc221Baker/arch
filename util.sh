#!/bin/bash

set -e

sudo pacman -S --needed power-profiles-daemon
sudo systemctl enable --now power-profiles-daemon

sudo pacman -S --needed bluez bluez-utils
sudo pacman -S --needed pacman-contrib

sudo sed -i 's/^#\?SystemMaxUse=.*/SystemMaxUse=300M/' /etc/systemd/journald.conf
sudo sed -i 's/^#\?SystemMaxFileSize=.*/SystemMaxFileSize=100M/' /etc/systemd/journald.conf

sudo systemctl restart systemd-journald
sudo pacman -S --needed cpupower

sudo sed -i 's/^#\?HandlePowerKey=.*/HandlePowerKey=ignore/' /etc/systemd/logind.conf

sudo pacman -S --needed intel-gpu-tools

sudo pacman -S --needed lm_sensors
sudo sensors-detect --auto

sudo systemctl enable --now fstrim.timer

sudo pacman -S --needed less

echo "Success."
