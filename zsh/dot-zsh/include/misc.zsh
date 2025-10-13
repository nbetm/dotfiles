# shellcheck disable=all

# Directories Listings
alias ls="ls --color=auto"
alias ll="ls --all --human-readable --classify -l"
alias l1="ls --almost-all -1"
alias lw="l1 | wc -l"
alias l="ll"

# Verbose/Interactive File Operations
alias cp="cp -v -i"
alias mv="mv -v -i"
alias rm="rm -v -i"

# File System Listings
alias df="df -h -P"

# History
alias history="history -i"

# bat vs cat
alias cat="bat"

# grep
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# sudo
alias s="sudo"
alias ssu="sudo su -"

# Direnv
alias de="direnv"
alias dea="direnv allow"
alias der="direnv reload"

# SSH
ssh() {
    # Always override TERM for SSH, even in tmux Remote servers often don't have
    # tmux-* terminfo entries

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

# Tmux
alias t="tmux"
alias tsn="tmux new -As"
alias tsl="tmux list-sessions"
alias tsk="tmux kill-session"
alias tska="tmux kill-session -a"
alias twr='tmux renamew $(basename $(pwd))'

# vim/nvim
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias vn="NVIM_APPNAME=vnext nvim"

# Homebrew
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

# Python
alias venvrm="find -name .venv -type d -print0 | xargs -0 rm -fr"
alias pipu="python -m pip install --upgrade pip setuptools wheel"
alias pipi="python -m pip install"
pipr() {
    local _req_file _req_dev_file

    _req_file="requirements.txt"
    _req_dev_file="requirements-dev.txt"

    if [[ -f $_req_dev_file ]]; then
        python -m pip install -r "$_req_dev_file"
    elif [[ -f $_req_file ]]; then
        python -m pip install -r "$_req_file"
    else
        echo "No requirements file found." >&2
        exit 1
    fi
}

# Terraform
# Set `tf` to use to autocompletes for `terraform`.
# compdef tf=terraform
alias tf="terraform"
alias tfi="terraform init"
alias tfiu="terraform init -upgrade"
alias tfpa="terraform apply plan.tfplan && rm -f plan.tfplan"
alias tfpar="terraform apply -refresh-only plan.tfplan && rm -f plan.tfplan"
alias tfw="terraform workspace"
alias tfwl="terraform workspace list"
alias tfwn="terraform workspace new"
alias tfws="terraform workspace select"
alias tffmt="terraform fmt"
alias tfs="terraform state"
alias tfsl="terraform state list"
alias tfprovlock="terraform providers lock -platform darwin_arm64 -platform darwin_amd64 -platform linux_amd64"
alias tflocalrm="find -name .terraform -type d -print0 | xargs -0 rm -fr"
tfp() {
    local _var_file

    _var_file="$(terraform workspace show).tfvars"
    if [[ -f $_var_file ]]; then
        terraform plan -var-file="$_var_file" -out=plan.tfplan
    else
        terraform plan -out=plan.tfplan
    fi
}
tfa() {
    local _var_file

    _var_file="$(terraform workspace show).tfvars"
    if [[ -f $_var_file ]]; then
        terraform apply -var-file="$_var_file"
    else
        terraform apply
    fi
}
tfar() {
    local _var_file

    _var_file="$(terraform workspace show).tfvars"
    if [[ -f $_var_file ]]; then
        terraform apply -refresh-only -var-file="$_var_file"
    else
        terraform apply -refresh-only
    fi
}
tfdestroy() {
    local _var_file

    _var_file="$(terraform workspace show).tfvars"
    if [[ -f $_var_file ]]; then
        terraform destroy -var-file="$_var_file"
    else
        terraform destroy
    fi
}

# Nomad
alias nm="nomad"

# Ansible
alias ans="ansible"
alias ansp="ansible-playbook --diff"
alias anspc="ansible-playbook --diff --check"

# AWS
if [[ $OS_NAME == "Darwin" ]]; then
    alias aws="/opt/homebrew/bin/aws"
    alias aws_completer="/opt/homebrew/bin/aws_completer"
fi

alias awspu="unset AWS_PROFILE"
awsl() {
    local _choice

    _choice=$(sed -nr "s/^\[profile (.+)\]$/\1/p" ~/.aws/config | fzf)
    if [[ -n "$SSH_TTY" ]]; then
        aws sso login --no-browser --profile "$_choice"
    else
        aws sso login --profile "$_choice"
    fi

    export AWS_PROFILE="$_choice"
}
awsp() {
    local _choice

    if [[ -f ~/.aws/config ]]; then
        _choice=$(sed -nr "s/^\[profile (.+)\]$/\1/p" ~/.aws/config | fzf)
    else
        _choice="default"
    fi
    export AWS_PROFILE="$_choice"
}

# Xpanes
alias xpssh="xpanes -s -c 'ssh -o StrictHostKeyChecking=no {}'"
alias xpsshv="xpanes -l ev -s -c 'ssh -o StrictHostKeyChecking=no {}'"
alias xpsshh="xpanes -l eh -s -c 'ssh -o StrictHostKeyChecking=no {}'"
alias xpping="xpanes -s -c 'ping -n {}'"
alias xppingv="xpanes -l ev -s -c 'ping -n {}'"
alias xppingh="xpanes -l eh -s -c 'ping -n {}'"

# What's my IP
alias whatismyip="dig +short myip.opendns.com @resolver1.opendns.com"

# SSL Checks
sslcheck() {
    echo | openssl s_client -servername "$1" -connect "$1":443 2>/dev/null |
        openssl x509 -noout -issuer -dates -subject -fingerprint -pubkey
}
sslinfo() {
    echo | openssl s_client -servername "$1" -connect "$1":443 2>/dev/null |
        openssl x509 -noout -text -inform pem
}

# https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
# alternatives:
#   msgcat --color=test
colortest() {
    T="gYw" # The test text
    echo -e "\n                 40m     41m     42m     43m     44m     45m     46m     47m"
    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
        '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
        '  36m' '1;36m' '  37m' '1;37m'; do
        FG=${FGs// /}
        echo -en " $FGs \033[$FG  $T  "
        for BG in 40m 41m 42m 43m 44m 45m 46m 47m; do
            echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m"
        done
        echo
    done
    echo
}

# uv
uv-python-symlinks() {
    # Creates symlinks in $HOME/.local/bin for python versions installed with uv
    # https://github.com/willkg/dotfiles/blob/main/dotfiles/bin/uv-python-symlink

    local LOCALBIN="${HOME}/.local/bin"
    local UVDIR=$(uv python dir)

    # Create symlinks for pythonX.Y to uv-managed Pythons
    for ITEM in "${UVDIR}"/*; do
        BASEITEM=$(basename "${ITEM}")

        FULLVERSION=$(echo "${BASEITEM}" | cut -d "-" -f 2)
        MINORVERSION=$(echo "${FULLVERSION}" | rev | cut -f 2- -d "." | rev)
        DEST="${LOCALBIN}/python${MINORVERSION}"

        if [[ -L "${DEST}" ]]; then
            if [[ -e "${DEST}" ]]; then
                echo "${DEST} already exists and is valid. Nothing to do."
                continue
            else
                echo "${DEST} already exists but is broken. Removing."
                rm "${DEST}"
            fi
        fi

        ln -sf "${UVDIR}/${BASEITEM}/bin/python${MINORVERSION}" "${DEST}"
        echo "${DEST} created."
    done

    # Create symlink for python to latest uv-managed Python
    LATESTPYTHON=$(uv python find)
    DEST="${LOCALBIN}/python"

    if [[ -L "${DEST}" ]]; then
        if [[ -e "${DEST}" ]]; then
            echo "${DEST} already exists and is valid. Nothing to do."
        else
            echo "${DEST} already exists but is broken. Removing."
            rm "${DEST}"
        fi
    fi

    ln -sf "${LATESTPYTHON}" "${DEST}"
    echo "${DEST} created."
}

# Yazi
alias yz=yazi
