# Enable Powerlevel10k instant prompt. Must stay at the very top.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ── Env vars & PATH ────────────────────────────────────────────────────────────
source ~/.config/zsh/exports.zsh

# ── Oh My Zsh ──────────────────────────────────────────────────────────────────
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source "$ZSH/oh-my-zsh.sh"

# ── Aliases ────────────────────────────────────────────────────────────────────
source ~/.config/zsh/aliases.zsh

# ── Functions ──────────────────────────────────────────────────────────────────
source ~/.config/zsh/functions.zsh

# ── Navigation: zoxide (Rust z replacement) ────────────────────────────────────
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# ── Fuzzy finder ───────────────────────────────────────────────────────────────
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ── Powerlevel10k prompt (runs last) ──────────────────────────────────────────
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
