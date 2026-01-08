# vim: set ft=sh :
# Tool aliases and functions - SSH, tmux, editors, system utilities

# ------------------------------------------------------------------------------
# SSH
# ------------------------------------------------------------------------------

ssh() {
    # Always override TERM for SSH - remote servers often don't have
    # modern terminfo entries

    if [[ -n "$KITTY_PID" ]]; then
        # Kitty kitten handles terminfo deployment automatically
        kitty +kitten ssh "$@"
    else
        # Fallback - use widely compatible TERM
        TERM=xterm-256color command ssh "$@"
    fi
}

alias gssh="TERM=xterm-ghostty command ssh"
alias ssha="ssh-add -l"
alias sshar="ssh-add -D && ssh-add ~/.ssh/id_ed25519-nbetm ~/.ssh/id_ed25519-nbetm-gh"
alias sshaD="ssh-add -D"

# ------------------------------------------------------------------------------
# Tmux
# ------------------------------------------------------------------------------

alias t="tmux"
alias tsn="tmux new -As"
alias tsl="tmux list-sessions"
alias tsk="tmux kill-session"
alias tska="tmux kill-session -a"
alias twr='tmux renamew $(basename "$(pwd)")'

# ------------------------------------------------------------------------------
# Editors
# ------------------------------------------------------------------------------

alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias vn="NVIM_APPNAME=vnext nvim"

# ------------------------------------------------------------------------------
# File Managers
# ------------------------------------------------------------------------------

alias yz="yazi"
alias lzd="lazydocker"

# ------------------------------------------------------------------------------
# Xpanes
# ------------------------------------------------------------------------------

alias xpssh="xpanes -s -c 'ssh -o StrictHostKeyChecking=no {}'"
alias xpsshv="xpanes -l ev -s -c 'ssh -o StrictHostKeyChecking=no {}'"
alias xpsshh="xpanes -l eh -s -c 'ssh -o StrictHostKeyChecking=no {}'"
alias xpping="xpanes -s -c 'ping -n {}'"
alias xppingv="xpanes -l ev -s -c 'ping -n {}'"
alias xppingh="xpanes -l eh -s -c 'ping -n {}'"

# ------------------------------------------------------------------------------
# Homebrew (macOS only)
# ------------------------------------------------------------------------------

if [[ $OS_NAME == "Darwin" ]]; then
    alias bupd="brew update"
    alias bupdate="brew update"
    alias bupg="brew upgrade --greedy-auto-updates"
    alias bupgrade="brew upgrade --greedy-auto-updates"
    alias bclean="brew cleanup"
    alias bcleanup="brew cleanup"

    # Homebrew Bundle
    alias bb="brew bundle --global"
    alias bbd="brew bundle dump --global --brews --taps --casks --no-vscode --force"
    alias bbdump="brew bundle dump --global --brews --taps --casks --no-vscode --force"
    alias bbc="brew bundle check --global"
    alias bbcheck="brew bundle check --global"
    alias bbi="brew bundle install --global"
    alias bbinstall="brew bundle install --global"
    alias bbupg="brew bundle upgrade --global"
    alias bbupgrade="brew bundle upgrade --global"
    alias bbclean="brew bundle cleanup --global"
    alias bbcleanup="brew bundle cleanup --global"
fi
