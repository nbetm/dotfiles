# Core aliases and functions - essential shell utilities

# ------------------------------------------------------------------------------
# Directory Listings
# ------------------------------------------------------------------------------

alias ls="ls --color=auto"
alias ll="ls --all --human-readable --classify -l"
alias l1="ls --almost-all -1"
alias lw="l1 | wc -l"
alias l="ll"

# ------------------------------------------------------------------------------
# File Operations (verbose, interactive)
# ------------------------------------------------------------------------------

alias cp="cp -v -i"
alias mv="mv -v -i"
alias rm="rm -v -i"

# ------------------------------------------------------------------------------
# Filesystem
# ------------------------------------------------------------------------------

alias df="df -h -P"

# ------------------------------------------------------------------------------
# Text Tools
# ------------------------------------------------------------------------------

alias cat="bat"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# ------------------------------------------------------------------------------
# Sudo
# ------------------------------------------------------------------------------

alias s="sudo"
alias ssu="sudo su -"

# ------------------------------------------------------------------------------
# Direnv
# ------------------------------------------------------------------------------

alias de="direnv"
alias dea="direnv allow"
alias der="direnv reload"

# ------------------------------------------------------------------------------
# Misc Utilities
# ------------------------------------------------------------------------------

# What's my IP
alias whatismyip="dig +short myip.opendns.com @resolver1.opendns.com"

# Color test
# https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
colortest() {
    local T="gYw"
    echo -e "\n                 40m     41m     42m     43m     44m     45m     46m     47m"
    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
        '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
        '  36m' '1;36m' '  37m' '1;37m'; do
        FG=${FGs// /}
        echo -en " $FGs \033[$FG  $T  "
        for BG in 40m 41m 42m 43m 44m 45m 46m 47m; do
            echo -en " \033[$FG\033[$BG  $T  \033[0m"
        done
        echo
    done
    echo
}

# SSL certificate checks
sslcheck() {
    echo | openssl s_client -servername "$1" -connect "$1":443 2>/dev/null |
        openssl x509 -noout -issuer -dates -subject -fingerprint -pubkey
}

sslinfo() {
    echo | openssl s_client -servername "$1" -connect "$1":443 2>/dev/null |
        openssl x509 -noout -text -inform pem
}
