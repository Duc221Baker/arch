#!/bin/bash

# Google
rm -rf ~/.cache/Google
mkdir -p ~/.cache/Google

# VS Code
mkdir -p /home/duc/.config/Code/{Cache,CachedData,GPUCache,Code\ Cache}

# Thumbnails
rm -rf ~/.cache/thumbnails
mkdir -p ~/.cache/thumbnails

# Mesa
rm -rf ~/.cache/mesa_shader_cache
mkdir -p ~/.cache/mesa_shader_cache

# Fontconfig
rm -rf ~/.cache/fontconfig
mkdir -p ~/.cache/fontconfig

# JetBrains
rm -rf ~/.cache/JetBrains
mkdir -p ~/.cache/JetBrains

# Mozilla
rm -rf ~/.cache/mozilla
mkdir -p ~/.cache/mozilla

# Librewolf
rm -rf ~/.cache/librewolf
mkdir -p ~/.cache/librewolf

# Chromium
rm -rf ~/.cache/chromium
mkdir -p ~/.cache/chromium

# KDE
rm -rf ~/.cache/KDE
mkdir -p ~/.cache/KDE

# Noctalia
rm -rf ~/.cache/noctalia
mkdir -p ~/.cache/noctalia

# Kitty
rm -rf ~/.cache/kitty
mkdir -p ~/.cache/kitty

# Glycin
rm -rf ~/.cache/glycin
mkdir -p ~/.cache/glycin

# GTK-4.0
rm -rf ~/.cache/gtk-4.0
mkdir -p ~/.cache/gtk-4.0

# ImageMagick
rm -rf ~/.cache/ImageMagick
mkdir -p ~/.cache/ImageMagick

# Add tmpfs to /etc/fstab
sudo tee -a /etc/fstab > /dev/null <<'EOF'
tmpfs   /home/duc/.cache/Google   tmpfs   noatime,nosuid,nodev,mode=700,uid=1000,gid=1000,size=6G   0 0

# VS Code
tmpfs   /home/duc/.config/Code/Cache   tmpfs   noatime,nosuid,nodev,mode=700,uid=1000,gid=1000,size=512M   0 0
tmpfs   /home/duc/.config/Code/CachedData   tmpfs   noatime,nosuid,nodev,mode=700,uid=1000,gid=1000,size=256M   0 0
tmpfs   /home/duc/.config/Code/GPUCache   tmpfs   noatime,nosuid,nodev,mode=700,uid=1000,gid=1000,size=256M   0 0
tmpfs   /home/duc/.config/Code/Code\\040Cache   tmpfs   noatime,nosuid,nodev,mode=700,uid=1000,gid=1000,size=512M   0 0

# Thumbnails
tmpfs   /home/duc/.cache/thumbnails   tmpfs   noatime,nosuid,nodev,mode=700,uid=1000,gid=1000,size=512M   0 0

# Jetbrains
tmpfs   /home/duc/.cache/JetBrains   tmpfs   noatime,nosuid,nodev,mode=700,uid=1000,gid=1000,size=4G   0 0

# Mesa
tmpfs   /home/duc/.cache/mesa_shader_cache   tmpfs   noatime,nosuid,nodev,mode=700,uid=1000,gid=1000,size=1G   0 0

# Fontconfig
tmpfs   /home/duc/.cache/fontconfig   tmpfs   noatime,nosuid,nodev,mode=700,uid=1000,gid=1000,size=100M   0 0

# Mozilla
tmpfs   /home/duc/.cache/mozilla   tmpfs   noatime,nosuid,nodev,mode=700,uid=1000,gid=1000,size=1G   0 0

# Librewolf
tmpfs   /home/duc/.cache/librewolf   tmpfs   noatime,nosuid,nodev,mode=700,uid=1000,gid=1000,size=1G   0 0

# Chromium
tmpfs   /home/duc/.cache/chromium   tmpfs   noatime,nosuid,nodev,mode=700,uid=1000,gid=1000,size=1G   0 0

# KDE
tmpfs   /home/duc/.cache/KDE   tmpfs   noatime,nosuid,nodev,mode=700,uid=1000,gid=1000,size=512M   0 0

# Noctalia
tmpfs   /home/duc/.cache/noctalia   tmpfs   noatime,nosuid,nodev,mode=700,uid=1000,gid=1000,size=256M   0 0

# Kitty
tmpfs   /home/duc/.cache/kitty   tmpfs   noatime,nosuid,nodev,mode=700,uid=1000,gid=1000,size=128M   0 0

# Glycin
tmpfs   /home/duc/.cache/glycin   tmpfs   noatime,nosuid,nodev,mode=700,uid=1000,gid=1000,size=128M   0 0

# GTK-4.0
tmpfs   /home/duc/.cache/gtk-4.0   tmpfs   noatime,nosuid,nodev,mode=700,uid=1000,gid=1000,size=128M   0 0

# ImageMagick
tmpfs   /home/duc/.cache/ImageMagick   tmpfs   noatime,nosuid,nodev,mode=700,uid=1000,gid=1000,size=256M   0 0

EOF

echo "Success. Please reboot to apply changes."
