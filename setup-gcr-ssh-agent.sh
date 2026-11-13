#!/bin/bash

set -e

systemctl --user enable --now gcr-ssh-agent.socket

mkdir -p ~/.config/environment.d

cat > ~/.config/environment.d/ssh-agent.conf <<'EOF'
SSH_AUTH_SOCK=${XDG_RUNTIME_DIR}/gcr/ssh
EOF

echo "Success. Please log out and login to apply changes"
