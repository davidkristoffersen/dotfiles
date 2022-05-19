#!/usr/bin/bash

prog="SumatraPDF"
conf="settings"

config="$WIN_HOME/AppData/Local/$prog"
program="$WIN_ROOT/Program Files/$prog"
win_cwd="$(wslpath -w .)"

default_conf="$conf-default.ini"
light_conf="$conf-light.ini"
dark_conf="$conf-dark.ini"
win_conf="$prog-$conf.txt"

default_prog="$prog.exe"
light_prog="$prog-light.exe"
dark_prog="$prog-dark.exe"
theme="theme.cmd"

mklink() {
	src_name="$1"
	dst_name="$(basename "$2")"
	wsl_dst="$(dirname "$2")"
	dst="$(wslpath -w "$wsl_dst")"

	cd "$wsl_dst"

	backup "$dst_name"
	sudo rm -f "$dst_name"
	cmd.exe /C "mklink $dst\\$dst_name $win_cwd\\$src_name >nul"

	cd - >/dev/null
}

backup() {
	sudo cp -f "$1" "$1.bak"
}

init_files() {
	cd "$program"
	if [ ! -f "$default_prog" ]; then
		echo -e "$prog is not installed!"
		return
	fi

	if [ ! -f "$light_prog" ]; then
		cp $default_prog $light_prog
	fi
	if [ ! -f "$dark_prog" ]; then
		cp $default_prog $dark_prog
	fi

	cd $config
	if [ ! -d light ]; then
		mkdir light
	fi
	if [ ! -d dark ]; then
		mkdir dark
	fi

	cd - >/dev/null
}

main() {
	init_files

	mklink $theme "$program/$theme"
	mklink $default_conf "$config/$win_conf"
	mklink $light_conf "$config/light/$win_conf"
	mklink $dark_conf "$config/dark/$win_conf"
}

main
