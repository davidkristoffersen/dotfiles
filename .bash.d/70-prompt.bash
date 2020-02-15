#!/usr/bin/env bash

prompt_pre() {
	local pre="╭─"
	local post="╰─"
	local -a _pre=("$pre" "$post")
	declare -p _pre
}

prompt_path() {
	local path=""
	local -a path_arr
	IFS="/" read -ra path_arr <<< "$(pwd)"
	local path_len="$((${#path_arr[@]}-1))"
	local path_it=-1
	local path_padd=2
	if [ $path_len -eq 0 ]; then
		path="/"
	fi

	for i in "${path_arr[@]}"; do
		if [ $path_it -eq -1 ]; then
			((path_it++))
			continue
		elif [ $path_len -gt $((path_padd * 2)) ]; then
			if [ $path_it -lt $path_padd ]; then
				path="$path/$i"
			elif [ $path_it -gt $((path_len - $path_padd - 1)) ]; then
				path="$path/$i"
			elif [ $path_it -eq $path_padd ]; then
				path="$path/..."
			fi
		else
			path="$path/$i"
		fi
		((path_it++))
	done
	printf "$path"
}

prompt_git() {
	# Git branch detection
	local branch="$(git branch 2>/dev/null | grep '^*' | colrm 1 2)"
 	if [ "$branch" == " " ]; then
		branch=''
	fi
	printf "$branch"
}

prompt_ssh() {
	local _out=""
	_out+="$1[$RESET\u$RESET"
	_out+="$FAINT@$RESET"
	_out+="${HOSTNAME%%.*}$1]"
	printf "$_out"
}

prompt_exit() {
	local _out=""
	if [ "$1" != "0" ]; then
		_out="${RED}</3"
	else
		_out="${GREEN}<3"
	fi
	printf "$_out"
}

prompt_word() {
	local _sep=" "
	local _col="$1"
	shift
	local _args="$@"
	[ -z "$_args" ] && _sep=""
	PS1+="$RESET$_col$_args$_sep$RESET"
}

prompt_line() {
	PS1+="\n"
}

# Environment variable called by bash upon rendering the prompt
PROMPT_COMMAND=prompt_command
prompt_command() {
	# Previous commands' exit status
	local EXIT="$?"
	PS1=""

	# Create start of lines
	eval "$(prompt_pre)"

	# Start of line 0
	prompt_word $BYELLOW ${_pre[0]}

	# SSH info
	if $SSH; then
		prompt_word $BYELLOW $(prompt_ssh $BYELLOW)
	fi

	# Git info
	prompt_word $BMAGENTA $(prompt_git)

	# Path info
	prompt_word $BBLUE $(prompt_path)

	# Exit status info
	prompt_word $RESET $(prompt_exit $EXIT)

	# Start of line 1
	prompt_line
	prompt_word $BYELLOW ${_pre[1]}
}
