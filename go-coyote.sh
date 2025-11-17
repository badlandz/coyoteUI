#!/bin/bash
# go-coyote.sh: Unified install/update for coyoteUI
# Detects prior install, pulls baselines, deploys configs, updates submodules/Neovim
# Logs to ~/src/coyoteUI/log/YYMMDDHHMMSS-coyote.log

set -euo pipefail
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$PROJECT_DIR/log"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/$(date +%y%m%d%H%M%S)-coyote.log"
exec > >(tee -a "$LOG_FILE") 2>&1

echo "Starting coyoteUI $([ -f ~/.coyoteUI_installed ] && echo "update" || echo "install")..."

# Function: Copy live config to project if missing (baseline capture)
copy_baseline() {
  local src="$1" dest="$2"
  if [ ! -e "$dest" ] && [ -e "$src" ]; then
    mkdir -p "$(dirname "$dest")"
    cp -r "$src" "$dest"
    echo "Baseline captured: $src -> $dest"
  fi
}

# Capture baselines if project subdirs empty
[ ! -f "$PROJECT_DIR/bashrc/MVtoDOTbashrc.txt" ] && copy_baseline ~/.bashrc "$PROJECT_DIR/bashrc/MVtoDOTbashrc.txt"
[ ! -f "$PROJECT_DIR/tmux/MVtoDOTtmuxconf.txt" ] && copy_baseline ~/.tmux.conf "$PROJECT_DIR/tmux/MVtoDOTtmuxconf.txt"
[ ! -d "$PROJECT_DIR/nvim-config" ] && copy_baseline ~/.config/nvim "$PROJECT_DIR/nvim-config"

# Update submodules (pull upstreams)
if [ -f "$PROJECT_DIR/.gitmodules" ]; then
  git submodule update --init --recursive
  git submodule foreach git pull origin master
  echo "Submodules updated."
fi

# Rebuild Neovim from source if submodule present
if [ -d "$PROJECT_DIR/neovim-src" ]; then
  cd "$PROJECT_DIR/neovim-src"
  git checkout stable
  git pull
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
  cd "$PROJECT_DIR"
  echo "Neovim rebuilt from source."
fi

# Deploy configs to defaults (idempotent, robust for dirs)
deploy_config() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -d "$src" ]; then
    cp -r "$src/." "$dest/"
  else
    cp "$src" "$dest"
  fi
  echo "Deployed: $src -> $dest"
}

deploy_config "$PROJECT_DIR/bashrc/MVtoDOTbashrc.txt" ~/.bashrc
deploy_config "$PROJECT_DIR/tmux/MVtoDOTtmuxconf.txt" ~/.tmux.conf
deploy_config "$PROJECT_DIR/nvim-config" ~/.config/nvim

# Run component bootstraps if needed (e.g., bashrc bootstrap)
if [ -f ~/.bashrc ]; then
  source ~/.bashrc || true
  echo "Bashrc sourced."
fi

# Mark as installed
touch ~/.coyoteUI_installed
echo "coyoteUI setup complete. Log: $LOG_FILE"
