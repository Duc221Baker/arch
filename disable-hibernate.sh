#!/bin/bash

set -e

sudo systemctl mask hibernate.target hybrid-sleep.target suspend-then-hibernate.target

sudo mkdir -p /etc/systemd/sleep.conf.d/

sudo tee /etc/systemd/sleep.conf.d/disable-hibernate.conf > /dev/null <<'EOF'
[Sleep]
AllowHibernation=no
AllowHybridSleep=no
AllowSuspendThenHibernate=no
EOF
