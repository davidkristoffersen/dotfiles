#!/usr/bin/bash

wslpath_win_dir="$WIN_HOME/AppData/Local/SumatraPDF"
win_dir="$(wslpath -w "$wslpath_win_dir")"
wsl_dir="$(wslpath -w .)"

src="settings.ini"
dst="SumatraPDF-settings.txt"

mklink() {
	cd $wslpath_win_dir
	sudo rm -f "$dst"
	cmd.exe /C "mklink $win_dir\\$dst $wsl_dir\\$src >nul"
	cd - >/dev/null
}

backup() {
	sudo cp -f "$src" "$wslpath_win_dir/$dst.bak"
}

main() {
	backup
	mklink
}

main
