# Oh My Zsh installation path
export ZSH="$HOME/.oh-my-zsh"

# Preferred editor
export EDITOR='nvim'
export VISUAL='nvim'

# NVM — Node Version Manager (lazy-loaded only if installed)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ]             && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ]    && \. "$NVM_DIR/bash_completion"

# PATH — user-local binaries (single source of truth; .profile also adds this
# but we set it here explicitly so it's available in all zsh sessions)
export PATH="$HOME/.local/bin:$PATH"

# WSL: Docker Desktop binary — only when running under WSL
[[ -d "/mnt/c/Program Files/Docker/Docker/resources/bin" ]] && \
    export PATH="$PATH:/mnt/c/Program Files/Docker/Docker/resources/bin"
