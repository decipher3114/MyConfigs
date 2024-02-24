#!/bin/bash

get_pkgs() {
    sudo apt update && sudo apt upgrade -y && apt install nala fish git -y
    curl -sS https://starship.rs/install.sh | sh
}

setup() {
    get_pkgs
    cd "$HOME" || true
    if ls "$HOME/MyConfigs" &> /dev/null; then
        cd "$HOME/MyConfigs" && git pull && cd "$HOME" || exit 1
    else
        git clone "https://github.com/decipher3114/MyConfigs.git" --depth=1
    fi
    mkdir -p "$HOME/.config/" && rm -rf "$HOME/.config/"* && ln -sf "$HOME/MyConfigs/.config/"* "$HOME/.config/"
    chsh -s fish
    fish -c "set -U fish_greeting && set -g fish_greeting"
}

setup
 