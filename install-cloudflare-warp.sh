#!/bin/bash

set -e

yay -S cloudflare-warp-bin

sudo systemctl enable --now warp-svc

systemctl --user enable --now warp-taskbar

echo "Success."
