#!/bin/bash

# Source inner template
. "$HOME/.local/lib/bash/run_template_inner.sh"

# Add option
add_option -s s -m multi -i "Info"

# Parse options
parse $@

# Script
