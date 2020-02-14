#!/usr/bin/env bash

# Add to path if directory exists and is not already in path
function path_add() {
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		PATH="$1:$PATH"
	fi
}

# User's bin
path_add "$HOME/bin"
# User's private bin
path_add "$HOME/.local/bin"
# Cargo's bin
path_add "$HOME/.cargo/bin"
# Basher's bin
path_add "$HOME/.basher/bin"

# Make path global
export PATH="$PATH"
