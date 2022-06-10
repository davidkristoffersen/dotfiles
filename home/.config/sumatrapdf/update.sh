#!/usr/bin/bash

prog="SumatraPDF"
conf="settings"

config="$WIN_HOME/AppData/Local/$prog"
program="$WIN_ROOT/Program Files/$prog"

default_conf="$conf-default.ini"
light_conf="$conf-light.ini"
dark_conf="$conf-dark.ini"
win_conf="$prog-$conf.txt"

default_prog="$prog.exe"
light_prog="$prog-light.exe"
dark_prog="$prog-dark.exe"
theme="theme.cmd"

INFO=true
DEBUG=true

init_files() {
	cd "$program"
	if [ ! -f "$default_prog" ]; then
		echo -e "$prog is not installed!"
		return
	fi

	file_copy_new $default_prog $light_prog
	file_copy_new $default_prog $dark_prog

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
	local src_dir="$(pwd)"

	file_update "$src_dir/$theme" "$program/$theme"
	file_update "$src_dir/$default_conf" "$config/$win_conf"
	file_update "$src_dir/$light_conf" "$config/light/$win_conf"
	file_update "$src_dir/$dark_conf" "$config/dark/$win_conf"
}

pushd . >/dev/null
cd $(dirname ${BASH_SOURCE[0]})
main $@
popd >/dev/null
