#!/usr/bin/env bash
set -euo pipefail

ME="$(id -un)"     # reliable in docker build
echo "Running user setup for: ${ME}"
echo "HOME=${HOME}"

# ------------------------------------------------------------
# Oh My Zsh (non-interactive)
# ------------------------------------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  export RUNZSH=no
  export CHSH=no
  export KEEP_ZSHRC=yes
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# ------------------------------------------------------------
# Zsh plugins
# ------------------------------------------------------------
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone --depth 1 \
    https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone --depth 1 \
    https://github.com/zsh-users/zsh-syntax-highlighting \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# ------------------------------------------------------------
# .zshrc configuration
# ------------------------------------------------------------
ZSHRC="$HOME/.zshrc"
touch "$ZSHRC"

# Theme
if ! grep -q '^ZSH_THEME=' "$ZSHRC"; then
  echo 'ZSH_THEME="robbyrussell"' >> "$ZSHRC"
fi

# Plugins
if grep -q '^plugins=' "$ZSHRC"; then
  sed -i \
    's/^plugins=.*/plugins=(git docker sudo zsh-autosuggestions zsh-syntax-highlighting)/' \
    "$ZSHRC"
else
  echo 'plugins=(git docker sudo zsh-autosuggestions zsh-syntax-highlighting)' >> "$ZSHRC"
fi

# ------------------------------------------------------------
# ROS 2 Jazzy sourcing
# ------------------------------------------------------------
if ! grep -q '/opt/ros/jazzy/setup.zsh' "$ZSHRC"; then
  cat >> "$ZSHRC" <<'EOF'

# ROS 2 Jazzy
if [ -f /opt/ros/jazzy/setup.zsh ]; then
  source /opt/ros/jazzy/setup.zsh
fi

# Workspace overlay
if [ -f /ws/install/setup.zsh ]; then
  source /ws/install/setup.zsh
fi
EOF
fi

echo "User setup completed."
