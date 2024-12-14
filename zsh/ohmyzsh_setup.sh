#!/bin/bash

set -e

DOTFILES_DIR="$HOME/dotfiles"
ZSH_DIR="$DOTFILES_DIR/zsh"
ZSH_CUSTOM="$ZSH_DIR/custom"
PLUGINS_DIR="$ZSH_CUSTOM/plugins"

# Install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "Oh My Zsh is already installed."
fi

# Symlink .zshrc
echo "Linking .zshrc..."
ln -sf "$ZSH_DIR/.zshrc" "$HOME/.zshrc"

# Create plugins directory
mkdir -p "$PLUGINS_DIR"

# Parse plugins from .zshrc
echo "Installing plugins..."
plugins=$(grep -oP '(?<=^plugins=\().*(?=\))' "$ZSH_DIR/.zshrc" | tr -d '\n' | tr ' ' '\n')

# Plugin repository map
declare -A plugin_repos=(
  ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
  ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions.git"
  ["zsh-completions"]="https://github.com/zsh-users/zsh-completions.git"
)

# Clone or update plugins
for plugin in $plugins; do
  if [ -d "$PLUGINS_DIR/$plugin" ]; then
    echo "Updating $plugin..."
    git -C "$PLUGINS_DIR/$plugin" pull --quiet
  else
    repo=${plugin_repos[$plugin]}
    if [ -n "$repo" ]; then
      echo "Installing $plugin..."
      git clone --quiet "$repo" "$PLUGINS_DIR/$plugin"
    else
      echo "No repository URL defined for $plugin. Skipping."
    fi
  fi
done

# Reload Zsh configuration
echo "Reloading Zsh..."
zsh -ic "source ~/.zshrc"

echo "Oh My Zsh setup complete!"
