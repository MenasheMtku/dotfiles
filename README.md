# Dotfiles

My personal Linux development environment — `zsh`, `tmux`, `neovim`, `kitty`, and `git` — all configured and ready to go on a fresh machine in one command.

**Supported distros:** Ubuntu · Debian · Fedora · Arch Linux

---

## Quick Start

> **Prerequisites:** `git` and `curl` must already be installed.

```bash
git clone git@github.com:MenasheMtku/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./setup.sh
```

That's it. The script handles everything else. See [What `setup.sh` does](#what-setupsh-does) for the full list.

After the script finishes, do these two things:

1. **Set your git identity** — fill in your name and email:
   ```bash
   nvim ~/.gitconfig.local
   ```

2. **Install tmux plugins** — open tmux and press `Ctrl+Space` then `I` (capital i).

Then open a new terminal and you're done.

---

## What `setup.sh` Does

The script is **idempotent** — running it multiple times is safe, it skips anything already installed.

| Step | What happens |
|---|---|
| Core packages | Installs `zsh`, `tmux`, `neovim`, `stow`, `git` via your distro's package manager |
| Modern CLI tools | Installs `lsd`, `lazygit`, `bat`, `ripgrep`, `fd`, `fzf`, `zoxide`, `delta` |
| Oh My Zsh | Installs OMZ + `zsh-autosuggestions` + `zsh-syntax-highlighting` |
| Tmux plugins | Clones TPM (Tmux Plugin Manager) |
| Symlinks | Links all configs into `$HOME` using `stow --restow` |
| Default shell | Sets `zsh` as your login shell |
| Git identity | Creates `~/.gitconfig.local` from the template on first run |

---

## Repo Structure

```
dotfiles/
├── setup.sh                        # Run this on a fresh machine
├── font_install.sh                 # Optional: install a Nerd Font from a URL
│
├── git/
│   ├── .gitconfig                  # Git settings, delta pager, aliases
│   └── .gitconfig.local.example   # Template for your name/email (copy, don't edit)
│
├── kitty/
│   └── .config/kitty/kitty.conf   # Terminal emulator config (Catppuccin Mocha)
│
├── nvim/
│   └── .config/nvim/
│       ├── init.lua                # Entry point — bootstraps Lazy.nvim
│       ├── lua/vim-options.lua     # Editor settings (tabs, leader key, etc.)
│       └── lua/plugins/           # One file per plugin
│
├── tmux/
│   └── .tmux.conf                  # Tmux config (Catppuccin Mocha, vi keybinds)
│
└── zsh/
    ├── .zshrc                      # Entry point — sources the three files below
    └── .config/zsh/
        ├── aliases.zsh             # All shell aliases
        ├── exports.zsh             # Environment variables and PATH
        └── functions.zsh          # Shell functions
```

---

## Zsh

The shell config is split into focused files so it's easy to find and edit things:

- **`aliases.zsh`** — all aliases in one place
- **`exports.zsh`** — environment variables, PATH, NVM
- **`functions.zsh`** — shell functions like `suu`

### Aliases

| Alias | Expands to | Notes |
|---|---|---|
| `ls`, `ll`, `la`, `lt`, `lh` | `lsd` variants | Color-coded directory listings |
| `cat` | `bat --paging=never` | Syntax-highlighted output |
| `grep` | `rg` | ripgrep — much faster |
| `find` | `fd` | Simpler, faster find |
| `lzg` | `lazygit` | Terminal git UI |
| `dtf` | `cd ~/dotfiles` | Jump to this repo |
| `zsc` | `nvim ~/.zshrc` | Edit shell config |
| `zss` | `source ~/.zshrc` | Reload shell config |
| `suu` | distro-aware upgrade | Works on apt, pacman, and dnf |

> Modern tool aliases (`bat`, `rg`, `fd`) fall back gracefully to the standard system tools if not installed.

---

## Tmux

**Prefix key:** `Ctrl+Space`

| Keys | Action |
|---|---|
| `h` / `j` / `k` / `l` | Move between panes (vim-style, requires prefix) |
| `Alt + Arrow` | Move between panes (no prefix needed) |
| `Shift + Arrow` | Switch windows |
| `"` | Split horizontally (opens in current directory) |
| `%` | Split vertically (opens in current directory) |
| `Prefix + I` | Install / update tmux plugins |
| `Prefix + d` | Detach from session |

**Plugins:** `catppuccin-tmux` · `tmux-resurrect` · `tmux-yank` · `vim-tmux-navigator`

---

## Neovim

Lua-based config using [Lazy.nvim](https://github.com/folke/lazy.nvim). All plugins install automatically on first launch — just open `nvim` and wait a moment.

**Leader key:** `Space`

### Keybindings

| Key | Action |
|---|---|
| `K` | Show hover documentation |
| `Space gd` | Go to definition |
| `Space gr` | Show all references |
| `Space ca` | Code actions |
| `Space rn` | Rename symbol |
| `Space gf` | Format file |
| `Ctrl+p` | Find files (Telescope) |
| `Space fg` | Search inside files (live grep) |
| `Ctrl+a` | Toggle file tree (Neo-tree) |
| `Ctrl+\` | Toggle floating terminal |

**LSP servers** (auto-installed via Mason): TypeScript · ESLint · TailwindCSS · HTML · CSS · JSON · Lua

**Format on save** is enabled using Prettier (via conform.nvim).

**AI completion** via [Codeium](https://codeium.com/) — free, no API key needed, just sign in on first use.

---

## Git

The tracked `~/.gitconfig` includes:

- **[delta](https://github.com/dandavison/delta)** as the diff pager — side-by-side diffs with line numbers and Catppuccin syntax highlighting
- **Shortcuts:** `git lg` (pretty log graph), `git st` (short status), `git co`, `git br`, `git last`
- `push.autoSetupRemote = true` — no more typing `--set-upstream` on new branches
- `init.defaultBranch = main`

**Your name and email are NOT in the tracked config.** They live in `~/.gitconfig.local`, which is included automatically but never committed. Copy the template to get started:

```bash
cp ~/dotfiles/git/.gitconfig.local.example ~/.gitconfig.local
nvim ~/.gitconfig.local
```

---

## Fonts (Optional)

All configs are set to use **JetBrains Mono Nerd Font**. If it's not installed, download it from [nerdfonts.com](https://www.nerdfonts.com/font-downloads) and run:

```bash
./font_install.sh <url-to-JetBrainsMono.zip>
```

---

## Theme

Everything uses **[Catppuccin Mocha](https://github.com/catppuccin/catppuccin)** — Neovim, Tmux, and Kitty all share the same palette so colors are consistent across tools.

---

## Troubleshooting

**`stow` fails with "existing target" error**
A real file (not a symlink) already exists at the target path, e.g. `~/.zshrc`. Back it up and re-run:
```bash
mv ~/.zshrc ~/.zshrc.bak
./setup.sh
```

**`ls` shows command not found**
`lsd` wasn't installed. Run `./setup.sh` again — it will pick up where it left off.

**Tmux looks unstyled**
TPM plugins haven't been installed yet. Open tmux and press `Ctrl+Space` then `I`.

**Neovim shows errors on first open**
Normal — Lazy.nvim is installing plugins. Wait for it to finish, then restart nvim.

**`suu` does nothing on my distro**
Only `apt`, `pacman`, and `dnf` are supported. Add your package manager to `functions.zsh`.
