# vim: set ft=zsh :
# shellcheck disable=all

function sesh-sessions() {
    sesh-picker
    zle reset-prompt >/dev/null 2>&1 || true
}

zle -N sesh-sessions
bindkey "^O" sesh-sessions
