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
    cat << EOF >> "$HOME/.termux/termux.properties" 
extra-keys =    [['~','/','-','_','UP','|','SHIFT'], \\
                ['TAB','CTRL','$','LEFT','DOWN','RIGHT','ENTER']]
allow-external-apps = true
terminal-cursor-style = bar
soft-keyboard-toggle-behaviour = enable/disable
EOF
    rm "$HOME/.config/starship.toml" &> /dev/null; ln -s "$HOME/MyConfigs/starship.toml" "$HOME/.config/"
}

ln -s "$HOME/MyConfigs/font.ttf" "$HOME/.termux/"
ln -s "$HOME/MyConfigs/colors.properties" "$HOME/.termux/"

setup
 