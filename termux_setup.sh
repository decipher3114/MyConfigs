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
    if ls "$HOME/MyConfigs" &> /dev/null; then
        cd "$HOME/MyConfigs" && git pull && cd "$HOME" || exit 1
    else
        git clone "https://github.com/decipher3114/MyConfigs.git" --depth=1
    fi
    cp "$HOME/MyConfigs/termux.properties" "$HOME/.termux/"
    rm "$HOME/.config/starship.toml" &> /dev/null; ln -s "$HOME/MyConfigs/starship.toml" "$HOME/.config/"
}

setup
 