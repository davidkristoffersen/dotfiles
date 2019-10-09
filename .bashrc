#!/bin/bash

# Environment status exports
. ~/.bash_env

# Shell options
. ~/.bash_shopt

# Shell prompt
. ~/.bash_prompt

# Secret exports and aliases
if ! $SSH && [ -z "$TMUX" ]; then
	. ~/.bash_secrets
fi

# Alias definitions
. ~/.bash_aliases

# Functions
. ~/.bash_funcs

# Cluster exports
if $UVCLUSTER; then
	. ~/.bash_uvcluster
fi
