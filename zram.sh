#!/bin/bash

set -e

# Install zram-generator
sudo pacman -S --needed --noconfirm zram-generator

# Configure ZRAM
cat > /etc/systemd/zram-generator.conf << 'EOF'
[zram0]
zram-size = 8192
compression-algorithm = zstd
swap-priority = 100
fs-type = swap
EOF

# Configure sysctl
sudo cat > /etc/sysctl.d/99-swappiness.conf << 'EOF'
vm.swappiness = 180
vm.watermark_boost_factor = 0
vm.watermark_scale_factor = 125
vm.page-cluster = 0
EOF

# Apply sysctl
sudo sysctl --system

echo "ZRAM configured! Please reboot."
