#!/usr/bin/bash

tree_dotfiles() {
	local _root="$(tree -a -I ".git|.vim" $DOTFILES)"
	local _vim="$(tree -a -I ".git" -L 2 $DOTFILES/.vim/)"

	local _root_meta="$(echo "$_root" | tail -n 1 | awk '{ print $1, " ", $3 }')"
	local _vim_meta="$(echo "$_vim" | tail -n 1 | awk '{ print $1, " ", $3 }')"
	local _dirs="$((${_root_meta%% *} + ${_vim_meta%% *}))"
	local _files="$((${_root_meta##* } + ${_vim_meta##* }))"

	printf "$_root" | head -n -2
	printf "$_vim" | head -n -2
	printf "\n$_dirs directories, $_files files\n"
}

pwd_list() {
	echo -e "/\n$(pwd | tr '/' ' ' | xargs -n 1 | head -n -1)"
}

pwd_full_list() {
	dir_list="$(pwd_list | tail -n +2)"
	path=""
	echo "/"
	while IFS= read -r line; do
		path="$path/$line"
		echo "$path"
	done <<<"$dir_list"
}

pwd_dot_list() {
	dir_list="$(pwd_list)"
	dir_num="$(wc -l <<<"$dir_list")"
	i=0
	while IFS= read -r line; do
		num_dots="$(($dir_num - $i))"
		num_spaces="$i"
		dots="$(printf '.%.0s' $(seq 0 $num_dots))"
		[ $num_spaces -ne 0 ] &&
			spaces="$(printf ' %.0s' $(seq 1 $num_spaces))" ||
			spaces=""
		echo "$spaces$dots $line"
		((i++))
	done <<<"$dir_list"
}

call_bash_func_if_exist $@
