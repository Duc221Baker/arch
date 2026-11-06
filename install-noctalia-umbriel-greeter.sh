#!/bin/bash

set -e

sudo pacman -S --needed noctalia-greeter noctalia kitty

yay -S umbriel-git

# Configure greetd
sudo mkdir -p /etc/greetd

sudo tee /etc/greetd/config.toml > /dev/null <<'EOF'
[terminal]
vt = 1

[default_session]
command = "/usr/bin/noctalia-greeter-session"
user = "greeter"
EOF

# Initialize Noctalia Greeter state
sudo systemd-tmpfiles --create noctalia-greeter.conf
sudo noctalia-greeter-apply-appearance --setup-system

sudo systemctl enable greetd

mkdir -p ~/.config/umbriel

cp /usr/share/umbriel/config.toml ~/.config/umbriel/config.toml

echo "Success. Configure umbriel and noctalia, then reboot system."
