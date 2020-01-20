#!/bin/bash

# Source inner template
. "$HOME/.local/lib/bash/run_template_inner.sh"

# Create initial variables
help_init "Example title text"

# Add option
add_option -s d -m data -i "Input text" -d "text"
add_option -s b -m bool -i "Make bool true"

# Parse options
parse "$@"

# Script
