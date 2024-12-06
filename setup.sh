#!/bin/bash

set -e

# Detect the distro
if [ -f /etc/os-release ]; then
  . /etc/os-release
  DISTRO=$ID
else
  echo "Unable to detect distro!"
  exit 1
fi

echo "Detected distro: $DISTRO"

# Install packages based on distro
case "$DISTRO" in
  ubuntu|debian)
    sudo apt update && sudo apt install -y zsh tmux neovim stow git
    ;;
  fedora)
    sudo dnf install -y zsh tmux neovim stow git
    ;;
  arch)
    sudo pacman -Syu --noconfirm zsh tmux neovim stow git
    ;;
  *)
    echo "Unsupported distro: $DISTRO"
    exit 1
    ;;
esac

# Symlink dotfiles
stow zsh tmux nvim

# Set ZSH as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
fi

echo "Setup complete!"

