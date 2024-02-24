#!/bin/bash

get_pkgs() {
    pkg update
    pkg upgrade -y -o Dpkg::Options::="--force-confnew"
    pkg install fish starship git -y -o Dpkg::Options::="--force-confnew"
}

setup() {
    get_pkgs
    cd "$HOME" || true
    rm "$HOME/../usr/etc/motd"
    if ls "$HOME/MyConfigs" &> /dev/null; then
        cd "$HOME/MyConfigs" && git pull && cd "$HOME" || exit 1
    else
        git clone "https://github.com/decipher3114/MyConfigs.git" --depth=1
    fi
    cat << EOF >> "$HOME/.termux/termux.properties" 
extra-keys =    [['~','/','-','_','UP','|','SHIFT'], \\
                ['TAB','CTRL','$','LEFT','DOWN','RIGHT','ENTER']]
allow-external-apps = true
terminal-cursor-style = bar
soft-keyboard-toggle-behaviour = enable/disable
EOF
    mkdir -p "$HOME/.config/" && rm -rf "$HOME/.config/"* && ln -sf "$HOME/MyConfigs/.config/"* "$HOME/.config/"
    ln -sf "$HOME/MyConfigs/.termux/"* "$HOME/.termux/"
    chsh -s fish
    fish -c "set -U fish_greeting && set -g fish_greeting"
}

setup
