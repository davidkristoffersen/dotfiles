#!/usr/bin/bash

function format() {
	while IFS= read -r line; do
		if [ "$func" != "seq" ]; then
			out+="$2$line$3"
		else
			echo -en "$2$line$3"
		fi
	done <<< "$1"
}

function update() {
	f="\e[2m"
	b="\e[1m"
	r="\e[0m"
	path="$(echo $1 | awk '{print $1}')"
	git_path="$(echo $1 | awk '{print $2}')"
	out=""

	format "$path - $git_path" $r$b "$r\n"
	format $force $r$f "$r\n"
	return

	cd $path

	# Check if head is detached
	git symbolic-ref -q HEAD 1>& /dev/null
	if [ "$?" != "0" ]; then
		obranch="$(git branch | grep -v ^* | head -n 1 | awk '{$1=$1};1')"
	else
		obranch="$(git branch --show-current)"
	fi

	origin="$(git remote get-url origin)"
	format "$git_path" $b "$r\n"
	format "$origin" " ↳ " "\n"

	format "git checkout $obranch" $r$f "$r\n"
	format "$(git checkout $obranch 2>&1)" $r "$r\n"
	format "git pull" $r$f "$r\n"
	format "$(git pull 2>&1)" "$r" "\n"

	if [ "$2" != "seq" ]; then
		echo -e "$out"
	fi
	cd - 1>/dev/null
}
export -f update
export -f format

function seq() {
	func="seq"
	while IFS= read -r line; do
		f1="$(awk '{print $1}' <<< "$line")"
		f2="$(awk '{print $2}' <<< "$line")"
		update "$f1 $f2 $force" "seq"
		echo
	done <<< "$(echo $args | xargs -n 2)"
}

function main() {
	submodules=($(git submodule | awk '{print $2}'))
	if ((${#submodules[@]} == 0)); then
		echo "fatal: repo has no submodules" >&2
		exit
	fi

	module="$(git submodule | awk '{print $2}' | grep /$2$)"
	if [ -z "$module" ]; then
		echo "Module does not exist: $2"
		exit
	fi

	path="$(pwd)"
	if [ "$1" == "--force" ]; then
		if [ -z "$2" ]; then
			exit
		fi
		args="$path/$module $module"
		force=true
	elif [ "$1" == "--all" ]; then
		args="$(echo ${submodules[@]} | tr ' ' "\n" | xargs -I {} echo "$path/{} {}")"
	elif [ "$1" == "-s" ]; then
		if [ -z "$2" ]; then
			exit
		fi
		args="$path/$module $module"
		force=false
	fi

	seq
}

function init() {
	path_bak="$(pwd)"

	if ! [[ "$1" =~ -s|--all|--force ]]; then
		echo "Usage: git submodulerm [-s|--force|--all] [SUBMODULE]"
		exit
	fi
	if ! [ -d .git ] || ! git rev-parse --git-dir > /dev/null 2>&1; then
		echo "fatal: not a git repository (or any parent up to mount point /)" >&2
		exit
	fi
	cd "$(git rev-parse --show-toplevel)"
	path="$(pwd)"
	main $@

	cd "$path_bak"
}

init $@
