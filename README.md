# Dotfiles

This repository contains my personal dotfiles for setting up a development environment. It includes configurations for `zsh`, `tmux`, and `neovim`. These dotfiles are designed to help you quickly set up your environment across different systems, with a focus on efficiency, customization, and a streamlined development workflow.

## File Structure

```plaintext
dotfiles/
├── font_install.sh             # A script to install fonts from a URL
├── nvim/                       # Neovim configuration folder
│   ├── init.lua                # Main Neovim configuration
│   ├── lazy-lock.json          # Neovim lazy plugin lock file
│   └── lua/
│       └── plugins/            # Neovim plugin configuration files
├── setup.sh                    # Setup script for installing required packages and linking dotfiles
├── tmux/                       # tmux configuration folder
├── zsh/                        # Zsh configuration folder
└── .zshrc                      # Zsh configuration file
```

## Installation Steps

Follow these steps to set up your environment using these dotfiles:
1. Clone the Repository

First, clone this repository into your home directory:

```bash
git clone https://github.com/your-username/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

## Run the Setup Script

The setup.sh script will detect your system's package manager (for Ubuntu, Debian, Fedora, or Arch) and install the necessary packages (zsh, tmux, neovim, stow, git). It will also symlink the dotfiles into their respective locations.

2. Make the script executable and run it:

```bash
chmod +x setup.sh
./setup.sh

```

This script will:

    Install essential packages based on your distribution (Ubuntu/Debian, Fedora, Arch).
    Symlink the dotfiles for zsh, tmux, and neovim using Stow.
    Set Zsh as your default shell.

## Install Fonts (Optional)

2. If you'd like to install custom fonts, use the font_install.sh script. You need to provide a URL to a .zip file containing the fonts.

```bash
./font_install.sh <nerdfont-zip-url>
```

This script will:

    Download the font file from the provided URL.
    Unzip the font file.
    Move the font files to the system font directory.
    Update the font cache.

## install lsd

 support) will be installed as part of the setup.sh script. Installation varies based on your system:

For WSL (or Debian/Ubuntu-based systems):

The setup.sh script will download and install the lsd package using dpkg:

```bash
wget https://github.com/Peltoche/lsd/releases/latest/download/lsd_amd64.deb
sudo dpkg -i lsd_amd64.deb
rm lsd_amd64.deb
```

For Other Linux Distributions:

The setup.sh script will use the appropriate package manager:

Ubuntu:
```bash
sudo snap insuall lsd
```

Arch Linux: Installs lsd using pacman:
```bash
sudo pacman -Syu lsd
```

Fedora: Installs lsd using dnf:
```bash
sudo dnf install lsd
```

If your distribution does not have lsd in its package repositories, the script will fallback to downloading the .deb package (as described for WSL). Alternatively, you can build lsd from source if needed.


## Configure Zsh

The .zshrc file contains several useful configurations for Zsh:

    The Agnoster theme for a nice prompt.
    Plugins like zsh-autosuggestions, zsh-syntax-highlighting, and git.
    Several helpful aliases like ls="lsd" for a better ls experience.

If Oh My Zsh isn't installed, the .zshrc will install it automatically.

## tmux Configuration

The .tmux.conf file contains several custom settings for tmux, such as:

    Window and pane numbering starting at 1.
    Keybindings to switch between panes and windows.
    Integration with several tmux plugins using TPM.

Key tmux plugins included are:

    tmux-resurrect: Saves and restores tmux sessions.
    tmux-yank: Allows copying text from tmux panes.
    vim-tmux-navigator: Seamless navigation between Vim and tmux panes.
    catppuccin-tmux: A theme for tmux that matches the Catppuccin theme.

To install the tmux plugins, press prefix + I after starting a tmux session.

## Neovim Configuration

Neovim is configured using Lua. The main configuration file is nvim/init.lua, which loads other Lua modules for plugins, settings, and LSP (Language Server Protocol) configurations.

The lua/plugins/ folder contains individual Lua files for configuring specific Neovim plugins:

    alpha.lua: Configures the startup screen.
    catppuccin.lua: Configures the Catppuccin color scheme.
    completions.lua: Configures autocompletion.
    lsp-config.lua: Configures LSP.
    neo-tree.lua: Configures the file explorer.
    telescope.lua: Configures the fuzzy finder.
    treesitter.lua: Configures syntax highlighting using Treesitter.

##  Customization

You can customize various settings in the following files:

    Zsh: Modify the theme and plugin list in .zshrc.
    Tmux: Adjust keybindings, colors, and plugins in .tmux.conf.
    Neovim: Edit the init.lua and the Lua plugin configurations to install new plugins and tweak settings.

##  Post-Installation

After setting up, you may want to:

    Customize the Zsh prompt and aliases.
    Add additional Neovim plugins to enhance your development workflow.
    Adjust tmux keybindings to suit your style.


## Requirements

    Zsh: The default shell is set to Zsh. Ensure that it is installed.
    Tmux: A terminal multiplexer for managing multiple terminal sessions.
    Neovim: The primary editor used in this setup.
    Font Installation: Fonts can be installed using the font_install.sh script (optional).

### License

Feel free to use, modify, and distribute these dotfiles for personal or professional use.    
