#!/bin/bash

# Source inner template
. "$HOME/.local/lib/bash/run_template_inner.sh"

# Create initial variables
help_init "Debug metadata of bash config files"

# Add option
add_option -s k -m key -i "Get metadata value with key" -d "key"
add_option -s p -m profile -i "Toggle debug mode on $HOME/.profile\nForce source $HOME/.profile on each shell instance"
add_option -s s -m status -i "Print all metadata"

# Parse options
parse "$@"

# Script
src="$XDG_DATA_HOME/bash-metadata/vars.json"

function get_val() {
	jq ".$1" $src
}

function set_val() {
	jq ".$1=$2" $src | sponge $src
}

if key_exists key; then
	jq ".${args[key]}" $src
elif key_exists profile; then
	if `get_val debug_profile`; then
		set_val debug_profile false
	else
		set_val debug_profile true
	fi
elif key_exists status; then
	cat $src | jq --tab
fi
