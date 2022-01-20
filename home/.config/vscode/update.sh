#!/usr/bin/bash

wslpath_win_dir="$WIN_HOME/AppData/Roaming/Code/User"
win_dir="$(wslpath -w "$WIN_HOME/AppData/Roaming/Code/User")"
wsl_dir="$(wslpath -w .)"

update() {
	cp -f "$1" "$wslpath_win_dir/$1.bak"
	rm -f "$wslpath_win_dir/$1"
	cd $wslpath_win_dir
	cmd.exe /C "mklink $win_dir\\$1 $wsl_dir\\$1 >nul"
	cd - >/dev/null
}

update settings.json
update keybindings.json
