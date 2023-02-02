#!/usr/bin/bash

wt() {
	git rev-parse --is-inside-work-tree 2>/dev/null 1>/dev/null
	if [[ $? -ne 0 ]]; then
		echo -e "Not a git repository!"
		return
	fi

	if [[ $# -ne 1 ]]; then
		echo -e "No argument received!"
		return
	fi

	local e_bak=${-//[^e]/}
	set -e

	local espaced=$(echo "$1" | sed 's/\//\\\//g')
	local main=""
	local DEBUG=false

	if [[ $1 == "-" ]]; then
		local directory=$(git worktree list --porcelain | awk '{print $0; exit}' | grep -oP '(?<=worktree ).*')
		local main="main "
	else
		local directory=$(git worktree list --porcelain | awk '/'"$espaced"'/ {print; exit}' | grep -oP '(?<=worktree ).*')
	fi

	local msg="Changing to ${main}worktree at: $directory"

	if [[ -n $e_bak ]]; then set -e; else set +e; fi

	if [[ ! -z $directory ]]; then
		$DEBUG && echo -e "$msg"
		cd $directory
	else
		echo -e "Worktree not found!"
	fi
}

export -f wt
