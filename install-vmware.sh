#!/bin/bash

set -e

sudo pacman -S linux-headers dkms
yay -S --needed vmware-keymaps
yay -S --needed vmware-workstation
