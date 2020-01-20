#!/usr/bin/env bash

# Source inner template
. "$HOME/.local/lib/bash/run_template_inner.sh"

# Create initial variables
help_init "Example title text"

# Add option
add_option -s d -m data -i "Input text\nCan be multiline" -d "text"
add_option -s b -m bool -i "Make bool true"

# Parse options
parse "$@"

# Script
if key_exists data; then
	echo "${args[data]}"
fi
