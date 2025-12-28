#!/usr/bin/env bash
# vim: set ft=bash :
#
# Infrastructure tools - Python, AWS, Terraform, Nomad, Ansible

# ------------------------------------------------------------------------------
# Python / pip
# ------------------------------------------------------------------------------

alias venvrm="find . -name .venv -type d -print0 | xargs -0 rm -fr"
alias pipu="python -m pip install --upgrade pip setuptools wheel"
alias pipi="python -m pip install"

pipr() {
    local req_file="requirements.txt"
    local req_dev_file="requirements-dev.txt"

    if [[ -f $req_dev_file ]]; then
        python -m pip install -r "$req_dev_file"
    elif [[ -f $req_file ]]; then
        python -m pip install -r "$req_file"
    else
        echo "No requirements file found." >&2
        return 1
    fi
}

# ------------------------------------------------------------------------------
# uv (Python package manager)
# ------------------------------------------------------------------------------

uv-python-symlinks() {
    # Creates symlinks in $HOME/.local/bin for python versions installed with uv
    # https://github.com/willkg/dotfiles/blob/main/dotfiles/bin/uv-python-symlink

    local LOCALBIN="${HOME}/.local/bin"
    local UVDIR
    UVDIR=$(uv python dir)

    # Create symlinks for pythonX.Y to uv-managed Pythons
    for ITEM in "${UVDIR}"/*; do
        local BASEITEM FULLVERSION MINORVERSION DEST
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
    local LATESTPYTHON DEST
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
