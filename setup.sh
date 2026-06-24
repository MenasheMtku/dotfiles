#!/usr/bin/env bash
# Idempotent dotfiles bootstrap — safe to run multiple times.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Distro detection ───────────────────────────────────────────────────────────
if [ ! -f /etc/os-release ]; then
  echo "ERROR: /etc/os-release not found. Only Linux is supported." >&2
  exit 1
fi
. /etc/os-release
DISTRO="${ID:-unknown}"
echo "Detected distro: $DISTRO"

# ── Package installer (distro-aware) ──────────────────────────────────────────
pkg_install() {
  case "$DISTRO" in
    ubuntu|debian)
      sudo apt-get install -y "$@"
      ;;
    fedora)
      sudo dnf install -y "$@"
      ;;
    arch)
      # --needed skips packages that are already up-to-date (idempotent)
      sudo pacman -S --noconfirm --needed "$@"
      ;;
    *)
      echo "Unsupported distro: $DISTRO" >&2
      exit 1
      ;;
  esac
}

# ── Core packages ─────────────────────────────────────────────────────────────
echo "Installing core packages..."
case "$DISTRO" in
  ubuntu|debian)
    sudo apt-get update -qq
    pkg_install zsh tmux neovim stow git curl wget unzip \
                ripgrep fd-find fzf bat zoxide
    ;;
  fedora)
    pkg_install zsh tmux neovim stow git curl wget unzip \
                ripgrep fd-find fzf bat zoxide
    ;;
  arch)
    pkg_install zsh tmux neovim stow git curl wget unzip \
                ripgrep fd fzf bat zoxide
    ;;
esac

# ── lsd (modern ls) ───────────────────────────────────────────────────────────
if ! command -v lsd &>/dev/null; then
  echo "Installing lsd..."
  pkg_install lsd 2>/dev/null || {
    # Fallback: download latest release from GitHub
    LSD_URL="$(curl -fsSL https://api.github.com/repos/lsd-rs/lsd/releases/latest \
      | grep "browser_download_url.*lsd.*x86_64.*linux.*musl.*tar.gz" \
      | head -1 | cut -d'"' -f4)"
    TMPDIR="$(mktemp -d)"
    curl -fsSL "$LSD_URL" | tar -xz -C "$TMPDIR"
    sudo install -m755 "$TMPDIR"/lsd*/lsd /usr/local/bin/lsd
    rm -rf "$TMPDIR"
  }
fi

# ── lazygit ───────────────────────────────────────────────────────────────────
if ! command -v lazygit &>/dev/null; then
  echo "Installing lazygit..."
  pkg_install lazygit 2>/dev/null || {
    LAZYGIT_VER="$(curl -fsSL https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
      | grep '"tag_name"' | cut -d'"' -f4 | sed 's/v//')"
    TMPDIR="$(mktemp -d)"
    curl -fsSL "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VER}/lazygit_${LAZYGIT_VER}_Linux_x86_64.tar.gz" \
      | tar -xz -C "$TMPDIR"
    sudo install -m755 "$TMPDIR/lazygit" /usr/local/bin/lazygit
    rm -rf "$TMPDIR"
  }
fi

# ── delta (git diff pager) ────────────────────────────────────────────────────
if ! command -v delta &>/dev/null; then
  echo "Installing delta..."
  case "$DISTRO" in
    ubuntu|debian) pkg_install git-delta 2>/dev/null || true ;;
    fedora)        pkg_install git-delta 2>/dev/null || true ;;
    arch)          pkg_install git-delta 2>/dev/null || true ;;
  esac
fi

# ── Oh My Zsh ─────────────────────────────────────────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    "" --unattended
fi

# ── OMZ custom plugins ────────────────────────────────────────────────────────
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# ── Tmux Plugin Manager (TPM) ─────────────────────────────────────────────────
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Installing TPM (Tmux Plugin Manager)..."
  git clone --depth=1 https://github.com/tmux-plugins/tpm \
    "$HOME/.tmux/plugins/tpm"
fi

# ── Stow dotfiles ─────────────────────────────────────────────────────────────
# --restow makes this idempotent: removes and recreates symlinks cleanly.
# Back up any real (non-symlink) ~/.gitconfig before stowing git.
echo "Symlinking dotfiles via stow..."
cd "$DOTFILES_DIR"
for pkg in zsh tmux nvim kitty; do
  stow --restow --target="$HOME" "$pkg"
done

# git config needs special care: an existing real ~/.gitconfig must be backed up
if [ -f "$HOME/.gitconfig" ] && [ ! -L "$HOME/.gitconfig" ]; then
  echo "Backing up existing ~/.gitconfig to ~/.gitconfig.bak"
  mv "$HOME/.gitconfig" "$HOME/.gitconfig.bak"
fi
stow --restow --target="$HOME" git

# ── Git identity (first-run prompt) ───────────────────────────────────────────
if [ ! -f "$HOME/.gitconfig.local" ]; then
  echo ""
  echo "No ~/.gitconfig.local found. Creating one from template..."
  cp "$DOTFILES_DIR/git/.gitconfig.local.example" "$HOME/.gitconfig.local"
  echo "Edit ~/.gitconfig.local to set your git name and email."
fi

# ── Default shell ─────────────────────────────────────────────────────────────
ZSH_BIN="$(command -v zsh)"
if [ "$SHELL" != "$ZSH_BIN" ]; then
  echo "Setting zsh as default shell..."
  chsh -s "$ZSH_BIN" "$USER"
fi

echo ""
echo "Setup complete! Open a new shell to apply all changes."
echo "Run 'tmux' and press Prefix+I to install tmux plugins."
