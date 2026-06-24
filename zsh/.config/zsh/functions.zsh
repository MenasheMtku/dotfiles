# Distro-aware system updater — replaces the apt-hardcoded 'suu' alias
suu() {
    if command -v apt &>/dev/null; then
        sudo apt update && sudo apt upgrade -y
    elif command -v pacman &>/dev/null; then
        sudo pacman -Syu
    elif command -v dnf &>/dev/null; then
        sudo dnf upgrade -y
    else
        echo "suu: no known package manager found (apt/pacman/dnf)" >&2
        return 1
    fi
}

# Suppress username@hostname in Oh My Zsh prompts
prompt_context() {}

# Shorten prompt to show only the current directory (one level deep)
prompt_dir() {
    prompt_segment blue $CURRENT_FG '%1~'
}
