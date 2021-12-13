#!/usr/bin/bash

# Add to path if directory exists and is not already in path
path_add() {
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
# Dotnet source
path_add "$HOME/.src/dotnet_sdk"
# Dotnet tools
path_add "$HOME/.dotnet/tools"
# Fzf's bin
path_add "$HOME/dotfiles/home/.vim/pack/general/opt/fzf/bin"
# Npm user directory
path_add "$HOME/.npm-global/bin"

# Make path global
export PATH="$PATH"
