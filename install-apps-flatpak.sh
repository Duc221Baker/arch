#!/bin/bash

set -e

flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install -y --user flathub com.obsproject.Studio com.github.tchx84.Flatseal com.usebottles.bottles

echo "Success."
