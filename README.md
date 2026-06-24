# Dotfiles

Personal development environment dotfiles for Linux. Covers `zsh`, `tmux`, `neovim`, `kitty`, and `git`. Uses [GNU Stow](https://www.gnu.org/software/stow/) for symlinking and supports Ubuntu/Debian, Fedora, and Arch Linux.

## Structure

```
dotfiles/
├── setup.sh                        # Idempotent bootstrap — run this first
├── font_install.sh                 # Install a Nerd Font from a zip URL
├── git/
│   ├── .gitconfig                  # Core git settings, delta pager, aliases
│   └── .gitconfig.local.example   # Template for name/email (not tracked)
├── kitty/
│   └── .config/kitty/kitty.conf   # Kitty terminal — Catppuccin Mocha
├── nvim/
│   └── .config/nvim/
│       ├── init.lua                # Lazy.nvim bootstrap
│       ├── lua/vim-options.lua     # Editor settings
│       └── lua/plugins/           # One file per plugin
├── tmux/
│   └── .tmux.conf                  # Catppuccin Mocha, TPM plugins, vi keys
└── zsh/
    ├── .zshrc                      # Thin entry point — sources modules below
    └── .config/zsh/
        ├── aliases.zsh             # All aliases
        ├── exports.zsh             # ENV vars and PATH
        └── functions.zsh          # Shell functions (suu, prompt helpers)
```

## Installation

### 1. Clone

```bash
git clone git@github.com:MenasheMtku/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Run the setup script

```bash
chmod +x setup.sh
./setup.sh
```

The script is **idempotent** — safe to run multiple times. It will:

- Install core packages: `zsh`, `tmux`, `neovim`, `stow`, `git`
- Install modern CLI tools: `lsd`, `lazygit`, `bat`, `ripgrep`, `fd`, `fzf`, `zoxide`, `delta`
- Install [Oh My Zsh](https://ohmyzsh.sh) + `zsh-autosuggestions` + `zsh-syntax-highlighting`
- Install [TPM](https://github.com/tmux-plugins/tpm) (Tmux Plugin Manager)
- Symlink all configs into `$HOME` via `stow --restow`
- Set `zsh` as your default shell
- Create `~/.gitconfig.local` from the template (first run only)

Supported distros: Ubuntu/Debian · Fedora · Arch Linux

### 3. Set your git identity

```bash
nvim ~/.gitconfig.local   # fill in name and email — this file is NOT tracked
```

### 4. Install tmux plugins

Start a tmux session and press `Prefix + I` (capital i) to install plugins via TPM.

### 5. Install fonts (optional)

```bash
./font_install.sh <url-to-nerd-font.zip>
```

The script downloads the zip, moves `.ttf`/`.otf` files to `/usr/local/share/fonts/`, and refreshes the font cache. The config uses **JetBrains Mono** — grab it from [nerdfonts.com](https://www.nerdfonts.com/).

---

## Zsh

`.zshrc` is a thin entry point that sources three modules:

| File | Contents |
|---|---|
| `exports.zsh` | `$ZSH`, `$EDITOR`, NVM, PATH additions |
| `aliases.zsh` | `lsd` file aliases, tool shortcuts, modern CLI replacements |
| `functions.zsh` | `suu` (distro-aware updater), prompt helpers |

**Key aliases:**

```zsh
ls / ll / la / lt   # lsd variants
cat                 # bat (syntax-highlighted)
grep                # ripgrep (rg)
find                # fd
lzg                 # lazygit
dtf                 # cd ~/dotfiles
zsc / zss           # edit / reload .zshrc
suu                 # distro-aware system update (apt / pacman / dnf)
```

Modern CLI aliases (`bat`, `rg`, `fd`) degrade gracefully — they fall back to the standard tool if not installed.

---

## Tmux

Prefix: `Ctrl+Space`

| Key | Action |
|---|---|
| `h/j/k/l` | Navigate panes (vim-style) |
| `Alt+Arrow` | Navigate panes (no prefix) |
| `Shift+Arrow` | Switch windows |
| `"` / `%` | Split (preserves cwd) |
| `Prefix+I` | Install TPM plugins |

Plugins: `catppuccin-tmux`, `tmux-resurrect`, `tmux-yank`, `vim-tmux-navigator`

---

## Neovim

Lua config using [Lazy.nvim](https://github.com/folke/lazy.nvim). Plugins auto-install on first launch.

**LSP servers** (via Mason): TypeScript, ESLint, TailwindCSS, HTML, CSS, JSON, Lua

**Key bindings:**

| Key | Action |
|---|---|
| `K` | Hover docs |
| `<leader>gd` | Go to definition |
| `<leader>gr` | Go to references |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<C-p>` | Telescope file finder |
| `<leader>fg` | Telescope live grep |
| `<C-a>` | Toggle Neo-tree |
| `<C-\>` | Toggle floating terminal |

Format on save is enabled (Prettier via conform.nvim). AI completion via [Codeium](https://codeium.com/).

---

## Git

`~/.gitconfig` (from `git/.gitconfig`) sets up:
- `delta` as the diff pager with side-by-side view and Catppuccin theme
- Useful aliases: `lg`, `st`, `co`, `br`, `last`
- `push.autoSetupRemote = true`
- `init.defaultBranch = main`

Personal identity (`user.name`, `user.email`) goes in `~/.gitconfig.local`, which is included but not tracked.

---

## Theme

Everything uses **Catppuccin Mocha** — Neovim, Tmux, and Kitty are all consistent.
