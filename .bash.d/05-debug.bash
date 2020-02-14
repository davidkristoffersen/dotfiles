#!/usr/bin/env bash

function debug_profile() {
	if [ ! -z "$1" ] && $1 && `debug_bash.sh -k debug_profile`; then
		source "$profile"
	fi
}
debug_profile false

export -f debug_profile
