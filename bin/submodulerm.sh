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
	name="$(basename $git_path)"
	out=""

	format "Removing: $git_path" $r$b "$r\n"

	format "git config -f .git/config --remove-section submodule.$git_path" $r$f "$r\n"
	git config -f .git/config --remove-section submodule.$git_path
	format "git config -f .gitmodules --remove-section submodule.$git_path" $r$f "$r\n"
	git config -f .gitmodules --remove-section submodule.$git_path

	format "git rm --cached $git_path" $r$f "$r\n"
	git rm --cached $git_path

	format "git commit -m \"Removed submodule: $name\"" $r$f "$r\n"
	git commit -m "Removed submodule: $name"

	if ! $force; then
		format "Force rm local repo? (y/N): " "$r$f" "$r"
		read do_force_rm </dev/tty
	fi
	if $force || ([ "$do_force_rm" == "y" ] || [ "$do_force_rm" == "Y" ]); then
		format "rm -rf "$git_path"" $r$f "$r\n"
		rm -rf "$git_path"
		format "rm -rf .git/modules/"$name"" $r$f "$r\n"
		rm -rf .git/modules/"$name"
	fi
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
