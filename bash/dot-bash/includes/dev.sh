#!/usr/bin/env bash
# vim: set ft=bash :
#
# Development tools - Python, uv, and related utilities

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
