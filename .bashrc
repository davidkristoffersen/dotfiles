#!/bin/bash

# Bash source files
b_env="$HOME/.bash_env"
b_shopt="$HOME/.bash_shopt"
b_promt="$HOME/.bash_prompt"
b_secrets="$HOME/.bash_secrets"
b_aliases="$HOME/.bash_aliases"
b_funcs="$HOME/.bash_funcs"
b_uvcluster="$HOME/.bash_uvcluster"

# Test if file exist and
# is either a regular file or a symlink
function source_test() {
	[ -f $1 ] || [ -L $1 ] \
		&& true \
		|| false
}

# Environment status exports
if source_test $b_env; then
	. $b_env
fi

# Shell options
if source_test $b_shopt; then
	. $b_shopt
fi

# Shell prompt
if source_test $b_promt; then
	. $b_promt
fi

# Secret exports and aliases
if source_test $b_secrets \
	&& [ -z "`pstree -ps $$ | grep sshd`" ] \
	&& [ -z "$TMUX" ]; then
	. $b_secrets
fi

# Alias definitions
if source_test $b_aliases; then
	. $b_aliases
fi

# Functions
if source_test $b_funcs; then
	. $b_funcs
fi

# Cluster exports
if source_test $b_uvcluster \
	&& [ ! -z "`ping -c 1 uvcluster 2>/dev/null`" ]; then
	. $b_uvcluster
fi
