#!/usr/bin/bash

function format() {
	while IFS= read -r line; do
		if [ "$func" == "par" ]; then
			out+="$2$line$3"
		else
			echo -en "$2$line$3"
		fi
	done <<< "$1"
}

function rebase() {
	format "git rebase upstream/$ubranch" "$r$f\t" "$r\n"
	reb="$(git rebase upstream/$ubranch 2>&1)"
	format "$reb" "$r\t" "\n"
	if [ "$reb" == "Current branch master is up to date." ]; then
		return
	fi

	while true; do
		git rebase --show-current-patch 2> /dev/null 1> /dev/null
		if [ "$?" != "0" ]; then
			break
		fi
		format "===================" "\n$r$f\t" "$r\n"
		format "git rebase conflict" "$r$f\t" "$r\n"
		format "===================" "$r$f\t" "$r\n"
		format "git status" "$r$f\t" "$r\n"
		format "$(git status)" "$r\t" "\n"
		format "Fix conflicts and the press Enter to continue... " "$r$f\t" "$r"
		read </dev/tty
		git rebase --show-current-patch 2> /dev/null 1> /dev/null
		if [ "$?" != "0" ]; then
			break
		fi
		format "git rebase --continue" "$r$f\t" "$r\n"
		format "$(git rebase --continue)" "$r\t" "\n"
	done

	format "Force push to origin? (y/N): " "$r$f\t" "$r"
	read do_force_push </dev/tty

	if [ "$do_force_push" == "y" ] || [ "$do_force_push" == "Y" ]; then
		format "git push -f" "$r$f\t" "$r\n"
		foramt "$(git push -f)" "$r\t" "\n"
	fi
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

	upstream_exist="$(git remote show | grep ^upstream$)"
	if [ -z "$upstream_exist" ] && [ -f ".ghconfig.json" ]; then
		upstream="$(ghconfig_parser.py .ghconfig.json upstream)"
		if [ ! -z "$upstream" ]; then
			git remote add upstream "$upstream"
			upstream_exist="true"
		fi
	fi

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

		if [ "$func" == "seq" ]; then
			rebase $ubranch
		fi
	fi

	if [ "$func" == "par" ]; then
		echo -e "$out"
	fi
	cd - 1>/dev/null
}
export -f update
export -f format

function par() {
	func="par"
	tagstring='\033[30;3{=$_=++$::color%8=}m'
	out="$(echo "$args" | parallel --tagstring $tagstring 'update 2>&1')"
	echo -e "$out"
}

function seq() {
	func="seq"
	while IFS= read -r line; do
		f1="$(awk '{print $1}' <<< "$line")"
		f2="$(awk '{print $2}' <<< "$line")"
		update "$f1 $f2"
		echo
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
if [ "$1" == "--single" ]; then
	if [ -z "$2" ]; then
		exit
	fi
	module="$(git submodule | awk '{print $2}' | grep /$2$)"
	if [ -z "$module" ]; then
		echo "Module does not exist: $2"
		exit
	fi
	args="$path/$module $module"
else
	args="$(echo ${submodules[@]} | tr ' ' "\n" | xargs -I {} echo "$path/{} {}")"
fi

which parallel 2>/dev/null 1>/dev/null
if [ $? -eq 0 ] && [ "$1" != "--seq" ] && [ "$1" != "--single" ]; then
	par
else
	seq
fi
