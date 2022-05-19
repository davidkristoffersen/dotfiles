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

info="\e[33m"
reset="\e[m"

mklink() {
	src="$(pwd)"
	src_name="$1"
	dst_name="$(basename "$2")"
	dst="$(dirname "$2")"

	cd "$dst"

	backup "$dst_name"

	# links="$dst_name $win_cwd\\$src_name"
	# echo -e "${info}Linking: " | tr -d '\n'
	# echo "$links" | tr -d '\n'
	# echo -e "$reset"
	# cmd.exe /C "mklink $links"
	echo -e "${info}cp \"$src/$src_name\" $dst_name$reset"
	cp "$src/$src_name" $dst_name

	cd - >/dev/null
}

backup() {
	echo -e "${info}Backup: $1$reset"
	sudo cp -f "$1" "$1.bak" 2>/dev/null
	echo -e "${info}Removing: $1$reset"
	sudo rm -f "$1" 2>/dev/null
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
	cd - >/dev/null

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
