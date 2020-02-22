#!/usr/bin/env bash

function script() {
	set_key value
	echo "value: $value"
}

function lib_args() {
	# Create initial variables
	help_init "Example title text"

	# Add option
	add_option -s e -m example -i "Example info text"
	add_option -s v -m value -i "Value option" -v "number" -d "12"
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
