#!/usr/bin/env bash

function script() {
	in="$HOME/.local/bin/run_template.sh"
	if [ ! -f "$in" ]; then
		echo "Template does not exist: $in"
	fi

	set_key out
	cp -n $in $out
}

function lib_args() {
	# Create initial variables
	help_init "Run template copy script"

	# Add option
	add_option -s o -m out -i "Output file name" -v "FILE" -d "."
}

#
# TEMPLATE LIBRARY INIT
#

# Source template library
lib="$HOME/.local/lib/bash/run_template_inner.sh"
if [ ! -f "$lib" ]; then echo "Library not found: $lib" >&2; exit; fi
. $lib
# Set argument options
lib_args
# Parse options
parse "$@"
# Run script
script
