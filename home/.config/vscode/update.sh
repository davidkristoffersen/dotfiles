#!/usr/bin/bash

wslpath_win_dir="$WIN_HOME/AppData/Roaming/Code/User"
win_dir="$(wslpath -w "$wslpath_win_dir")"
wsl_dir="$(wslpath -w .)"

mklink() {
	cd $wslpath_win_dir
	sudo rm -f "$1"
	cmd.exe /C "mklink $win_dir\\$1 $wsl_dir\\$1 >nul"
	cd - >/dev/null
}

backup() {
	sudo cp -f "$1" "$wslpath_win_dir/$1.bak"
}

main() {
	backup settings.json
	backup keybindings.json
}

main
