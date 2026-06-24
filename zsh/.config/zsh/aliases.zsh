# File and directory management (lsd required; installed by setup.sh)
alias ls='lsd'
alias ll='lsd -l'
alias la='lsd -a'
alias lt='lsd --tree'
alias lh='lsd -lh'
alias ld='lsd -d */'
alias lsbig='lsd -lh --sort=size | tail -n 10'

# Shell management
alias zsc='nvim ~/.zshrc'
alias zss='source ~/.zshrc'
alias cls='clear'

# Tool shortcuts
alias lzg='lazygit'
alias dtf='cd ~/dotfiles'

# Modern CLI replacements — gracefully degrade if tool not installed
# bat: syntax-highlighted cat (Debian/Ubuntu binary may be 'batcat')
if command -v bat &>/dev/null; then
    alias cat='bat --paging=never'
elif command -v batcat &>/dev/null; then
    alias cat='batcat --paging=never'
    alias bat='batcat'
fi

# ripgrep: fast recursive grep
command -v rg &>/dev/null && alias grep='rg'

# fd: fast find (Debian/Ubuntu binary may be 'fdfind')
if command -v fd &>/dev/null; then
    alias find='fd'
elif command -v fdfind &>/dev/null; then
    alias find='fdfind'
    alias fd='fdfind'
fi
