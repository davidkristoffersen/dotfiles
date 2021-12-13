#!/usr/bin/bash

config_dir="$WIN_HOME/AppData/Roaming/Code/User"

settings="settings.json"
keybindings="keybindings.json"
prettier=".prettierrc"

update() {
   cp "$config_dir/$1" "$config_dir/$1.bak"
   cp "$1" "$config_dir/$1"
}

update $settings
update $keybindings
update $prettier
