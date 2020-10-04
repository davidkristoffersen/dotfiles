#!/usr/bin/bash

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

	# Check if head is detached
	git symbolic-ref -q HEAD 1>& /dev/null
	if [ "$?" != "0" ]; then
		rbranch="$(git branch | grep -v ^* | head -n 1 | awk '{$1=$1};1')"
	else
		rbranch="$(git branch --show-current)"
	fi

	origin="$(git remote get-url origin)"
	format "$git_path" $b "$r\n"
	format "$origin" " ↳ " "\n"

	format "git checkout $rbranch" $r$f "$r\n"
	format "$(git checkout $rbranch 2>&1)" $r "$r\n"
	format "git pull" $r$f "$r\n"
	format "$(git pull 2>&1)" "$r" "\n"

	upstream_exist="$(git remote show | grep ^upstream$)"
	if [ ! -z "$upstream_exist" ]; then
		ubranch="master"
		upstream="$(git remote get-url upstream)"
		format "Fork" "$b\t" "$r\n"
		format "$upstream" "\t ↳ " "\n"
		format "git fetch upstream" "$r$f\t" "$r\n"

		tmp="$(git fetch upstream 2>&1)"
		if [ ! -z "$tmp" ]; then
			format "$tmp" "$r\t" "\n"
		fi

		format "git merge upstream/$ubranch $rbranch" "$r$f\t" "$r\n"
		format "$(git merge upstream/$ubranch $rbranch 2>&1)" "$r\t" "\n"
	fi

	echo -e "$out"
	cd - 1>/dev/null
}
export -f update
export -f format

function par() {
	tagstring='\033[30;3{=$_=++$::color%8=}m'
	out="$(echo "$args" | parallel --tagstring $tagstring 'update 2>&1')"
	echo -e "$out"
}

function seq() {
	while IFS= read -r line; do
		f1="$(awk '{print $1}' <<< "$line")"
		f2="$(awk '{print $2}' <<< "$line")"
		update $f1 $f2
	done <<< "$(echo $args | xargs -n 2)"
}

if ! [ -d .git ] || ! git rev-parse --git-dir > /dev/null 2>&1; then
	echo "fatal: not a git repository (or any parent up to mount point /)" >&2
	exit
fi

submodules=($(git submodule | awk '{print $2}'))
if ((${#submodules[@]} == 0)); then
	echo "fatal: repo has no submodules" >&2
	exit
fi

if [ -z "$(git submodule summary)" ]; then
	git submodule update --init --recursive
fi

path="$(pwd)"
args="$(echo ${submodules[@]} | tr ' ' "\n" | xargs -I {} echo "$path/{} {}")"

which parallel 2>/dev/null 1>/dev/null
[ $? -eq 0 ] && par || seq
