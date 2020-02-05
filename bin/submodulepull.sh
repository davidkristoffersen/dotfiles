#!/usr/bin/env bash

function update() {
	f="\e[2m"
	b="\e[1m"
	r="\e[m"
	path="$(echo $1 | awk '{print $1}')"
	git_path="$(echo $1 | awk '{print $2}')"

	cd $path

	origin="$(git remote get-url origin)"
	echo -e "$b$git_path$r -> $origin"

	echo -e "${f}git checkout master$r"
	git checkout master
	echo -e "${f}git pull$r"
	git pull

	upstream_exist="$(git remote show | grep ^upstream$)"
	if [ ! -z "$upstream_exist" ]; then
		upstream="$(git remote get-url upstream)"
		echo -e "${b}Fork$r -> $upstream"
		echo -e "${f}git fetch upstream$r"
		git fetch upstream
		echo -e "${f}git merge upstream/master master$r"
		git merge upstream/master master
		fi
	echo

	cd - 1>/dev/null
}
export -f update

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

out="$(echo "$args" | parallel 'update 2>&1')"
echo -e "$out"
