#!/usr/bin/env bash

src="$XDG_DATA_HOME/bash-metadata/vars.json"

function help() {
	echo -e "Usage: ./debug_bash.sh -[kps] [ARGS]..."
	echo -e "\t-h, --help\tPrint this help message"
	echo
	echo -e "\t-k, --key\tGet metadata value with key"
	echo -e "\t-p, --profile\tToggle debug mode on $HOME/.profile"
	echo -e "\t\t\t\t\tForce source $HOME/.profile on each shell instance"
	echo -e "\t-s, --status\tPrint all metadata"
}

function get_val() {
	jq ".$1" $src
}

function set_val() {
	jq ".$1=$2" $src | sponge $src
}

if ([ "$1" == "-k" ] || [ "$1" == "--key" ]) && [ ! -z "$2" ]; then
	jq ".$2" $src
elif [ "$1" == "-p" ] || [ "$1" == "--profile" ]; then
	if `get_val debug_profile`; then
		set_val debug_profile false
	else
		set_val debug_profile true
	fi
elif [ "$1" == "-s" ] || [ "$1" == "--status" ]; then
	cat $src | jq --tab
elif [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
	help
else
	help
fi
