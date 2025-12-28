#!/usr/bin/env bash
# vim: set ft=bash :
#
# Cloud and infrastructure tools - AWS, Terraform, Nomad, Ansible

# ------------------------------------------------------------------------------
# AWS
# ------------------------------------------------------------------------------

if [[ $OS_NAME == "Darwin" ]]; then
    alias aws="/opt/homebrew/bin/aws"
    alias aws_completer="/opt/homebrew/bin/aws_completer"
fi

alias awspu="unset AWS_PROFILE"

awsl() {
    local choice
    choice=$(sed -nr "s/^\[profile (.+)\]$/\1/p" ~/.aws/config | fzf)

    [[ -z "$choice" ]] && return

    if [[ -n "$SSH_TTY" ]]; then
        aws sso login --no-browser --profile "$choice"
    else
        aws sso login --profile "$choice"
    fi

    export AWS_PROFILE="$choice"
}

awsp() {
    local choice

    if [[ -f ~/.aws/config ]]; then
        choice=$(sed -nr "s/^\[profile (.+)\]$/\1/p" ~/.aws/config | fzf)
    else
        choice="default"
    fi

    [[ -n "$choice" ]] && export AWS_PROFILE="$choice"
}

# ------------------------------------------------------------------------------
# Terraform
# ------------------------------------------------------------------------------

alias tf="terraform"
alias tfi="terraform init"
alias tfiu="terraform init -upgrade"
alias tfp="terraform plan"
alias tfa="terraform apply"
alias tfar="terraform apply -refresh-only"
alias tfw="terraform workspace"
alias tfwl="terraform workspace list"
alias tfwn="terraform workspace new"
alias tfws="terraform workspace select"
alias tffmt="terraform fmt"
alias tfs="terraform state"
alias tfsl="terraform state list"
alias tfdestroy="terraform destroy"
alias tfprovlock="terraform providers lock -platform darwin_arm64 -platform darwin_amd64 -platform linux_amd64"
alias tflocalrm="find . -name .terraform -type d -print0 | xargs -0 rm -fr"

# ------------------------------------------------------------------------------
# Nomad
# ------------------------------------------------------------------------------

alias nm="nomad"

# ------------------------------------------------------------------------------
# Ansible
# ------------------------------------------------------------------------------

alias ans="ansible"
alias ansp="ansible-playbook --diff"
alias anspc="ansible-playbook --diff --check"
