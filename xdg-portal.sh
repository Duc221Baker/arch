#!/bin/bash

set -e

mkdir -p ~/.config/xdg-desktop-portal

cat >> ~/.config/xdg-desktop-portal/portals.conf <<'EOF'
[preferred]
default=gtk
org.freedesktop.impl.portal.ScreenCast=umbriel

EOF

echo "Success."
