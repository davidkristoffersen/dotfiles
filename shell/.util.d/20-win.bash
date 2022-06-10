#!/usr/bin/bash

win_cmd() {
	[ ! -z "$WIN_HOME" ] && cd "$WIN_HOME" || cd "$(win_get_env USERPROFILE)"
	echo "cmd.exe /C \"$@ >nul\""
	cmd.exe /C "$@ >nul"
	cd - >/dev/null
}

win_cmd_out() {
	[ ! -z "$WIN_HOME" ] && cd "$WIN_HOME" || cd "$(win_get_env USERPROFILE)"
	cmd.exe /C "$@"
	cd - >/dev/null
}

win_get_env() {
	echo "$(wslpath "$(wslvar $1)")"
}

win_set_env() {
	win_cmd "setx $1 $2"
}

export -f win_cmd win_cmd_out win_get_env win_set_env
