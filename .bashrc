#!/bin/bash

# Profile
profile="$HOME/.profile"

# Test source file names
declare -a bash_files=( \
	# Environment status exports
	env \
	# Shell options
	shopt \
	# Shell prompt
	prompt \
	# Secret exports and aliases
	secrets \
	# Alias definitions
	aliases \
	# Functions
	funcs \
	# Completions
	completion
	# Cluster exports
	uvcluster \
)

# Test source prepend
bash_pre="$HOME/.bash_"

# Sourced file names
declare -a BASH_SOURCE_FILES
declare -a BASH_FILES

# Test if file exist and
# is either a regular file or a symlink
function source_test() {
	[ -f $1 ] || [ -L $1 ] \
		&& true \
		|| false
}

# Source profile if debug mode is enabled
if source_test $profile && `debug_bash.sh -k debug_profile`; then
	source "$profile"
fi

for bash_file in ${bash_files[@]}; do
	# Do not source if case and if test is true
	case $bash_file in
		secrets)
			# If ssh or tmux session
			if [ ! -z "`pstree -ps $$ | grep sshd`" ] \
				|| [ ! -z "$TMUX" ]; then
				continue
			fi
			;;
		uvcluster)
			# If not uvcluster session
			if [ -z "`ping -c 1 uvcluster 2>/dev/null`" ]; then
				continue
			fi
			;;
		*)
			;;
	esac

	# Create absolute file path
	bash_file="$bash_pre$bash_file"

	# All files that can exist
	BASH_FILES[${#BASH_FILES[@]}]=$bash_file

	# Do not source if file do not exist
	if source_test $bash_file; then
		BASH_SOURCE_FILES[${#BASH_SOURCE_FILES[@]}]=$bash_file
		# Source file
		source $bash_file
	fi
done

# List of all files sourced
export BASH_SOURCE_FILES="${BASH_SOURCE_FILES[@]}"
export BASH_FILES="$HOME/.profile ${bash_pre}profile $HOME/.bashrc ${BASH_FILES[@]} ${bash_pre}logout"
