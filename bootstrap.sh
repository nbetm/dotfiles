#!/usr/bin/env bash
#
# Set options:
#   e: Stop script if command fails
#   u: Stop script if unset variable is referenced
#   x: Debug, print commands as they are executed
#   f: Disable file name generation (globbing).
#   o pipefail: If any command in a pipeline fails it all fails
#
set -eufo pipefail

# LOCAL_BIN="${HOME}/.local/bin"
OS_NAME=$(uname -s) # Darwin, Linux
OS_ARCH=$(uname -m) # x86_64, arm64

_print_usage() {
    echo "Usage: bootstrap.sh [OPTION]"
}

_sudo_rule() {
    # check if sudo is installed
    if ! type sudo > /dev/null; then
        >&2 echo "ERROR: sudo is not installed"
        exit 1
    fi

    # allow user $USER to run sudo without password
    echo "==> Adding user $USER to sudoers"
    echo "$USER ALL=NOPASSWD: ALL" | sudo tee /etc/sudoers.d/99-custom
}

_install_homebrew() {
    echo "==> Installing Homebrew"
    if [ ! -d "/opt/homebrew" ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        /opt/homebrew/bin/brew install stow
    fi
}

_install_homebrew_packages() {
    echo "==> Installing Homebrew packages from bundle"
    /opt/homebrew/bin/stow homebrew
    /opt/homebrew/bin/brew bundle install --global
}

_install_linux_packages() {
    local _packages=(
        avahi-daemon
        avahi-utils
        btop
        build-essential
        curl
        dbus-user-session
        direnv
        fuse
        gettext
        git
        git-doc
        ipcalc
        jq
        leiningen
        lf
        libbz2-dev
        libevent-dev
        libffi-dev
        libfuse-dev
        liblzma-dev
        libpq-dev
        libreadline-dev
        libsqlite3-dev
        libssl-dev
        libxml2-dev
        libxmlsec1-dev
        llvm
        lsb-release
        lvm2
        make
        neofetch
        openvpn
        pgcli
        postgresql-client
        ripgrep
        rsync
        samba
        shellcheck
        silversearcher-ag
        smbclient
        stow
        tig
        tk-dev
        tmux
        ttfautohint
        uidmap
        unzip
        vim
        wget
        xz-utils
        zip
        zlib1g-dev
        zsh
        zsh-doc
    )

    # install packages from debian repositories
    echo "==> Installing packages"
    sudo apt-get update && sudo apt-get install -y "${_packages[@]}"
    sudo apt-get clean

    # ncdu
    echo "==> Installing package: ncdu"
    curl -fsSL https://dev.yorhel.nl/download/ncdu-2.3-linux-x86_64.tar.gz -o /tmp/ncdu.tar.gz
    tar -xzf /tmp/ncdu.tar.gz -C /tmp
    sudo cp /tmp/ncdu /usr/local/bin/ncdu
    sudo chmod +x /usr/local/bin/ncdu
    rm -rf /tmp/ncdu.tar.gz /tmp/ncdu

    # gitui
    echo "==> Installing package: gitui"
    curl -fsSL https://github.com/extrawurst/gitui/releases/download/v0.26.3/gitui-linux-x86_64.tar.gz -o /tmp/gitui.tar.gz
    tar -xzf /tmp/gitui.tar.gz -C /tmp
    sudo cp /tmp/gitui /usr/local/bin/gitui
    sudo chmod +x /usr/local/bin/gitui
    rm -rf /tmp/gitui.tar.gz /tmp/gitui

    # nvim
    local _custom_nvim_path=/usr/local/bin/nvim
    echo "==> Installing package: nvim"
    curl -fsSL https://github.com/neovim/neovim/releases/download/v0.10.3/nvim.appimage -o /tmp/nvim.appimage
    sudo chmod +x /tmp/nvim.appimage
    sudo cp /tmp/nvim.appimage "$_custom_nvim_path"
    rm -rf /tmp/nvim.appimage
    sudo update-alternatives --install /usr/bin/ex ex "$_custom_nvim_path" 110
    sudo update-alternatives --install /usr/bin/vi vi "$_custom_nvim_path" 110
    sudo update-alternatives --install /usr/bin/view view "$_custom_nvim_path" 110
    sudo update-alternatives --install /usr/bin/vim vim "$_custom_nvim_path" 110
    sudo update-alternatives --install /usr/bin/vimdiff vimdiff "$_custom_nvim_path" 110

    # starship
    echo "==> Installing package: starship"
    curl -fsSL https://starship.rs/install.sh | sh

    # aws cli
    echo "==> Installing package: aws-cli"
    curl -fsSL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o /tmp/awscliv2.zip
    pushd /tmp
    unzip /tmp/awscliv2.zip
    sudo ./aws/install --update
    popd
    rm -fr /tmp/awscliv2.zip /tmp/aws

    # fzf
    echo "==> Installing package: fzf"
    if [ -d "$HOME/.fzf" ]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    else
        pushd "$HOME/.fzf"
        git pull
        popd
    fi
    ~/.fzf/install --bin

    # yazi
    echo "==> Installing package: yazi"
    curl -fsSL https://github.com/sxyazi/yazi/releases/download/v25.3.2/yazi-x86_64-unknown-linux-gnu.zip -o /tmp/yazi.zip
    pushd /tmp
    unzip /tmp/yazi.zip
    sudo cp /tmp/yazi-x86_64-unknown-linux-gnu/ya* /usr/local/bin
    popd
    rm -fr /tmp/yazi*

    # bat
    local _bat_version=0.25.0
    echo "==> Installing package: bat"
    curl -fsSL https://github.com/sharkdp/bat/releases/download/v${_bat_version}/bat-v${_bat_version}-i686-unknown-linux-gnu.tar.gz \
        -o /tmp/bat-${_bat_version}.tar.gz
    tar -xzf /tmp/bat-${_bat_version}.tar.gz -C /tmp
    sudo cp /tmp/bat-v${_bat_version}-i686-unknown-linux-gnu/bat /usr/local/bin/bat
    sudo cp /tmp/bat-v${_bat_version}-i686-unknown-linux-gnu/bat.1 /usr/local/share/man/man1/bat.1
    sudo rm -fr /tmp/bat*
}

_install_tmux_plugin_manager() {
    echo "==> Setting up tmux plugin manager"
    if [ ! -d "$XDG_CONFIG_HOME/tmux/plugins/tpm" ]; then
        mkdir -p "$XDG_CONFIG_HOME/tmux/plugins/tpm"
        git clone https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME/tmux/plugins/tpm"
    fi
}

_install_cheatsheets() {
    echo "==> Setting up cheatsheets"
    if [ ! -d "$HOME/.config/cheat/cheatsheets/community" ]; then
        mkdir -p "$HOME/.config/cheat/cheatsheets/community"
        git clone https://github.com/cheat/cheatsheets.git "$HOME/.config/cheat/cheatsheets/community"
    fi
}

_install_uv() {
    curl -LsSf https://astral.sh/uv/install.sh | sh
}

_install_fonts(){
    echo "==> Setting up fonts"
    tar -zxf fonts/iosevka-n-fixed.tgz -C ~/Library/Fonts
    tar -zxf fonts/iosevka-n-quasi-proportional.tgz -C ~/Library/Fonts
    tar -zxf fonts/iosevka-n-term.tgz -C ~/Library/Fonts
    tar -zxf fonts/iosevka-n.tgz -C ~/Library/Fonts
    tar -zxf fonts/misc.tgz -C ~/Library/Fonts
    tar -zxf fonts/opensans.tgz -C ~/Library/Fonts
    tar -zxf fonts/roboto.tgz -C ~/Library/Fonts
}

_stow_configs() {
    echo "==> Stowing configs"
    stow bat btop cheat direnv ghostty git gitui homebrew kitty ncdu pip starship tmux yazi zsh
}

bootstrap_macos() {
    echo "==> Bootstrapping macOS"
    _sudo_rule
    _install_homebrew
    _install_homebrew_packages
    _install_tmux_plugin_manager
    _install_cheatsheets
    _install_uv
    _install_fonts
    _stow_configs
}

bootstrap_linux() {
    echo "==> Bootstrapping Linux"
    _sudo_rule
    _install_linux_packages
    _install_tmux_plugin_manager
    _install_cheatsheets
    _install_uv
    _stow_configs
}

case ${OS_NAME} in
    Darwin)
        bootstrap_macos
        ;;
    Linux)
        if [[ "${OS_ARCH}" != "x86_64" ]]; then
            >&2 echo "ERROR: Unsupported OS and Arch: ${OS_NAME}-${OS_ARCH}"
            exit 1
        fi
        bootstrap_linux
        ;;
    *)
        >&2 echo "ERROR: Unsupported OS: ${OS_NAME}"
        exit 1
        ;;
esac
