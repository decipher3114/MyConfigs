#!/usr/bin/bash

get_pkgs() {
    pkg update
    pkg upgrade -y
    pkg install fish starship git -y
}

setup() {
    get_pkgs
    cd "$HOME" || true
    rm "$HOME/../usr/etc/motd"
    chsh -s fish
    fish -c "set -U fish_greeting && set -g fish_greeting"
    echo -e "export USER=decipher\nstarship init fish | source" > "$HOME/.config/fish/config.fish"
    ls "$HOME/MyConfigs" > /dev/null 2>&1 || git clone "https://github.com/decipher3114/MyConfigs.git" --depth=1
    cp "$HOME/MyConfigs/termux.properties" "$HOME/.termux/"
    rm "$HOME/.config/starship.toml" > /dev/null 2>&1; ln -s "$HOME/MyConfigs/starship.toml" "$HOME/.config/"
}

setup
 