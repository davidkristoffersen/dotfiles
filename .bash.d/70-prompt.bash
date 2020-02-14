#!/bin/bash

PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs
__prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1=""

    local rcol='\[\e[0m\]'
    local red='\[\e[0;31m\]'
    local gre='\[\e[0;32m\]'
    local byel='\[\e[1;33m\]'
    local bblu='\[\e[1;34m\]'
    local bpur='\[\e[1;35m\]'
	local fbla='\[\e[2m\]'

	# Git branch detection
	local branch="$(git branch 2>/dev/null | grep '^*' | colrm 1 2) "
 	if [ "$branch" == " " ]; then
		branch=''
	fi

	# Create truncated path
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

	local pre="$rcol$byel╭─ $rcol"
	local post="$rcol\n$byel╰─$rcol "

    PS1+="$pre"

	# Add user and host if it is a ssh session
	if $SSH; then
		PS1+="$byel[$rcol\u$rcol"
		PS1+="$fbla@$rcol"
		PS1+="${HOSTNAME%%.*}$byel]$rcol "
	fi

	PS1+="$bpur$branch$rcol"
	PS1+="$bblu$path$rcol "

	# Color based exit status
    if [ $EXIT != 0 ]; then
        PS1+="${red}</3${rcol}"
    else
        PS1+="${gre}<3${rcol}"
    fi

    PS1+="$post"
}
