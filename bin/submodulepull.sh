#!/usr/bin/env bash

function format() {
	while IFS= read -r line; do
		out+="$2$line$3"
	done <<< "$1"
}

function update() {
	f="\e[2m"
	b="\e[1m"
	r="\e[0m"
	path="$(echo $1 | awk '{print $1}')"
	git_path="$(echo $1 | awk '{print $2}')"
	out=""

	cd $path

	origin="$(git remote get-url origin)"
	format "$git_path" $b "$r\n"
	format "$origin" " ↳ " "\n"

	format "git checkout master" $r$f "$r\n"
	format "$(git checkout master 2>&1)" $r "$r\n"
	format "git pull" $r$f "$r\n"
	format "$(git pull 2>&1)" "$r" "\n"

	upstream_exist="$(git remote show | grep ^upstream$)"
	if [ ! -z "$upstream_exist" ]; then
		upstream="$(git remote get-url upstream)"
		format "Fork" "$b\t" "$r\n"
		format "$upstream" "\t ↳ " "\n"
		format "git fetch upstream" "$r$f\t" "$r\n"

		tmp="$(git fetch upstream 2>&1)"
		if [ ! -z "$tmp" ]; then
			format "$tmp" "$r\t" "\n"
		fi

		format "git merge upstream/master master" "$r$f\t" "$r\n"
		format "$(git merge upstream/master master 2>&1)" "$r\t" "\n"
	fi

	echo -e "$out"
	cd - 1>/dev/null
}
export -f update
export -f format

if ! [ -d .git ] || ! git rev-parse --git-dir > /dev/null 2>&1; then
	echo "fatal: not a git repository (or any parent up to mount point /)" >&2
	exit
fi

submodules=($(git submodule | awk '{print $2}'))
if ((${#submodules[@]} == 0)); then
	echo "fatal: repo has no submodules" >&2
	exit
fi

path="$(pwd)"
args="$(echo ${submodules[@]} | tr ' ' "\n" | xargs -I {} echo "$path/{} {}")"

tagstring='\033[30;3{=$_=++$::color%8=}m'
out="$(echo "$args" | parallel --tagstring $tagstring 'update 2>&1')"
echo -e "$out"
