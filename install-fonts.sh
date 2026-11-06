#!/bin/bash

set -e

sudo pacman -S --needed noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-jetbrains-mono inter-font

mkdir -p ~/.config/fontconfig

cat > ~/.config/fontconfig/fonts.conf <<'EOF'
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <alias>
    <family>sans-serif</family>
    <prefer>
      <family>Noto Sans</family>
    </prefer>
  </alias>

  <alias>
    <family>serif</family>
    <prefer>
      <family>Noto Serif</family>
    </prefer>
  </alias>

  <alias>
    <family>monospace</family>
    <prefer>
      <family>JetBrains Mono</family>
    </prefer>
  </alias>
</fontconfig>
EOF

fc-cache -fv

echo "Success. Please log out and login to apply changes"
