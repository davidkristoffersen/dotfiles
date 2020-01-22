#!/usr/bin/env bash

# Source inner template
function lib_init() {
	local lib="$HOME/.local/lib/bash/run_template_inner.sh"
	if [ ! -f "$lib" ]; then
		echo "Library not found: $lib" >&2
		exit
	fi
	. $lib
}

function args_init() {
	# Create initial variables
	help_init "Example title text"

	# Add option
	add_option -s d -m data -i "Input text\nCan be multiline" -d "text"
	add_option -s b -m bool -i "Make bool true"
}

# Source library
lib_init
# Set argument options
args_init
# Parse options
parse "$@"

# Script
if key_exists data; then
	echo "Data: $(get_key data)"
else
	echo "Data not found!"
fi
