#!/bin/bash

set -e

# Install zram-generator
sudo pacman -S --needed --noconfirm zram-generator

# Configure ZRAM
sudo tee /etc/systemd/zram-generator.conf > /dev/null << 'EOF'
[zram0]
zram-size = 8192
compression-algorithm = zstd
swap-priority = 100
fs-type = swap
EOF

# Configure sysctl
sudo tee /etc/sysctl.d/99-swappiness.conf > /dev/null << 'EOF'
vm.swappiness = 180
vm.watermark_boost_factor = 0
vm.page-cluster = 0
EOF

# Apply sysctl
sudo sysctl --system

echo "ZRAM configured! Please reboot."
