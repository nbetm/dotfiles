# shellcheck disable=all

# Directories Listings
alias ls='ls --color=auto'
alias ll='ls --all --human-readable --classify -l'
alias l1='ls --almost-all -1'
alias lw='l1 | wc -l'
alias l='ll'

# Verbose/Interactive File Operations
alias cp='cp -v -i'
alias mv='mv -v -i'
alias rm='rm -v -i'

# File System Listings
alias df='df -h -P'

# History
alias history='history -i'

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# sudo
alias s='sudo'
alias ssu='sudo su -'

# Direnv
alias de='direnv'
alias dea='direnv allow'

# SSH
alias ssh="TERM=xterm-256color ssh"
alias ssha="ssh-add -l"
alias sshar="ssh-add -D && ssh-add ~/.ssh/id_ed25519-nbetm ~/.ssh/id_ed25519-nbetm-a8c ~/.ssh/id_ed25519-nbetm-gh ~/.ssh/id_rsa-emr ~/.ssh/id_rsa-devops ~/.ssh/id_rsa-product"
alias sshaD="ssh-add -D"
alias kssh="kitty +kitten ssh"

# Tmux
# alias tmux='[ -z "$TMUX" ] && TERM=xterm-256color tmux'
alias t='tmux'
alias tn='tmux new -As'
alias tls='tmux list-sessions'
alias trw='tmux renamew $(basename $(pwd))'

# vim/nvim
alias vim='nvim'
alias vi='nvim'

# Homebrew
if [[ $OS_NAME == "Darwin" ]]; then
    alias bupd='brew update'
    alias bupdate='brew update'
    alias bupg='brew upgrade --greedy-auto-updates'
    alias bupgrade='brew upgrade --greedy-auto-updates'
    alias bcl='brew cleanup'
    alias bclean='brew cleanup'
    alias bcleanup='brew cleanup'

    alias bb='brew bundle --global'
    alias bbd='/bin/rm -f $HOME/._Brewfile && brew bundle dump --cask --formula --tap --file $HOME/._Brewfile && sort -o $HOME/._Brewfile{,}'
    alias bbdump='/bin/rm -f $HOME/._Brewfile && brew bundle dump --cask --formula --tap --file $HOME/._Brewfile && sort -o $HOME/._Brewfile{,}'
    alias bbc='brew bundle check --global'
    alias bbcheck='brew bundle check --global'
    alias bbi='brew bundle install --global'
    alias bbinstall='brew bundle install --global'
fi

# Python
alias pvenvrm="find -name .venv -type d -print0 | xargs -0 /bin/rm -fr"
alias pvrm="find -name .venv -type d -print0 | xargs -0 /bin/rm -fr"
alias piu="python -m pip install --upgrade pip setuptools wheel"
alias pi="python -m pip install"
pir() {
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
alias tfprovl="terraform providers lock -platform darwin_arm64 -platform darwin_amd64 -platform linux_amd64"
alias tfprovlock="terraform providers lock -platform darwin_arm64 -platform darwin_amd64 -platform linux_amd64"
alias tflrm="find -name .terraform -type d -print0 | xargs -0 /bin/rm -fr"
alias tflocalrm="find -name .terraform -type d -print0 | xargs -0 /bin/rm -fr"
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

# Ansible
alias ans="ansible"
alias ansp="ansible-playbook --diff"
alias anspc="ansible-playbook --diff --check"

# AWS
if [[ $OS_NAME == "Darwin" ]]; then
    alias aws="/opt/homebrew/bin/aws"
    alias aws_completer="/opt/homebrew/bin/aws_completer"
else
    alias aws="/usr/local/bin/aws"
    alias aws_completer="/usr/local/bin/aws_completer"
fi

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
    echo | openssl s_client -servername "$1" -connect "$1":443 2>/dev/null | \
        openssl x509 -noout -issuer -dates -subject -fingerprint -pubkey
}
sslinfo() {
    echo | openssl s_client -servername "$1" -connect "$1":443 2>/dev/null | \
        openssl x509 -noout -text -inform pem
}

# https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
# alternatives:
#   msgcat --color=test
colortest() {
    T='gYw'   # The test text
    echo -e "\n                 40m     41m     42m     43m     44m     45m     46m     47m";
    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
               '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
               '  36m' '1;36m' '  37m' '1;37m'; do
        FG=${FGs// /}
        echo -en " $FGs \033[$FG  $T  "
        for BG in 40m 41m 42m 43m 44m 45m 46m 47m; do
            echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
        done
        echo;
    done
    echo
}