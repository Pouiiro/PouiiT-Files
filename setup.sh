#!/usr/bin/env bash

# Pouiiro's Dotfiles Setup Script
# Supports macOS (Homebrew) and Ubuntu/Debian (apt)

set -e

REPO_URL="https://github.com/Pouiiro/PouiiT-Files"
CONFIG_DIR="$HOME/.config"

print_section() {
  echo -e "\n\033[1;34m== $1 ==\033[0m"
}

print_section "Installing dependencies"

if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  if ! command -v brew >/dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew install neovim node kitty ripgrep fd fzf lazygit yabai skhd
  brew install --cask jetbrains-mono
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Ubuntu/Debian
  sudo apt update
  sudo apt install -y neovim nodejs npm ripgrep fd-find fzf git curl
  # Kitty install
  if ! command -v kitty >/dev/null; then
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh
    ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/kitty
  fi
  # Nerd Font
  echo "Download and install JetBrainsMono Nerd Font manually: https://www.nerdfonts.com/font-downloads"
else
  echo "Unsupported OS. Please install dependencies manually."
fi

print_section "Cloning dotfiles repo"
if [ ! -d "$CONFIG_DIR" ]; then
  mkdir -p "$CONFIG_DIR"
fi
if [ ! -d "$CONFIG_DIR/nvim" ]; then
  git clone "$REPO_URL" "$CONFIG_DIR"
fi

print_section "Symlinking configs"
# Get current directory (repo root)
REPO_ROOT="$(pwd)"

# Symlink all folders and their contents from repo root to ~/.config
for item in "$REPO_ROOT"/*; do
  name=$(basename "$item")
  # Skip .git and setup.sh
  [[ "$name" == ".git" ]] && continue
  [[ "$name" == "setup.sh" ]] && continue
  # Symlink folder or file to ~/.config
  ln -sf "$item" "$HOME/.config/$name"
done

if [[ "$OSTYPE" == "darwin"* ]]; then
  ln -sf "$REPO_ROOT/yabai" "$CONFIG_DIR/yabai"
  ln -sf "$REPO_ROOT/skhd" "$CONFIG_DIR/skhd"
fi

print_section "Setting up AI allowed paths (optional)"
if ! grep -q NVIM_AI_ALLOWED_PATHS ~/.bashrc 2>/dev/null && ! grep -q NVIM_AI_ALLOWED_PATHS ~/.zshrc 2>/dev/null; then
  echo 'export NVIM_AI_ALLOWED_PATHS="$HOME/dev,$HOME/projects,$HOME/dotfiles"' >>~/.bashrc
  echo 'export NVIM_AI_ALLOWED_PATHS="$HOME/dev,$HOME/projects,$HOME/dotfiles"' >>~/.zshrc
  echo "Added NVIM_AI_ALLOWED_PATHS to ~/.bashrc and ~/.zshrc"
fi

print_section "All done!"
echo "Open Kitty and run 'nvim' to start."
echo "Set your terminal font to JetBrainsMono Nerd Font for best experience."
echo "On first Neovim launch, plugins will auto-install. Run :Mason to install LSPs."
