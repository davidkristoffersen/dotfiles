#!/usr/bin/bash

debug_profile() {
	if [ ! -z "$1" ] && $1 && $(debug_bash.sh -k debug_profile); then
		source "$profile"
	fi
}
debug_profile false

win_cmd() {
	[ ! -z "$WIN_HOME" ] && cd "$WIN_HOME" || cd "$(win_get_env USERPROFILE)"
	echo "cmd.exe /C \"$@ >nul\""
	cmd.exe /C "$@ >nul"
	cd - >/dev/null
}

win_get_env() {
	echo "$(wslpath "$(wslvar $1)")"
}

win_set_env() {
	win_cmd "setx $1 $2"
}

export -f debug_profile win_cmd win_get_env win_set_env
