#!/usr/bin/bash

code-style-format() {
	for i in $@; do
		backup_pos="/tmp/clang_format_backup/$(basename $i)$(date +%Y.%m.%d-%H:%M:%S).bak"
		mkdir -p /tmp/clang_format_backup
		mv $i $backup_pos
		cat $backup_pos | clang-format -style="$CLANG_FORMAT_CONFIG" > $i
	done
}

evalps1() {
	myprompt=${PS1@P}; printf '%s\n' "${myprompt//[$'\001'$'\002']}" | tr '\n' '\0'
}

format_patch() {
	git format-patch --base=$1 $1..$2 --stdout > "../patches/patch-$1-$2.patch";
}

hostname_master() {
	name="$1"
	tracepath -b 129.242.16.30 | grep "$name" | grep -e '^ 1:'
}

xresource_get() {
	if $XDISPLAY; then
		local _args="$(echo $@ | tr ' ' '.')"
		xrdb -query | grep -i "$_args:" | cut -f 2
	fi
}

# Archive extractor
extract() {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xjf $1   ;;
			*.tar.gz)    tar xzf $1   ;;
			*.bz2)       bunzip2 $1   ;;
			*.rar)       unrar x $1     ;;
			*.gz)        gunzip $1    ;;
			*.tar)       tar xf $1    ;;
			*.tbz2)      tar xjf $1   ;;
			*.tgz)       tar xzf $1   ;;
			*.zip)       unzip $1     ;;
			*.Z)         uncompress $1;;
			*.7z)        7z x $1      ;;
			*)           echo "'$1' cannot be extracted" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

_lll() {
	ls_sorted false -lh $@
}
_lla() {
	ls_sorted true -lh $@
}
_ll() {
	ls_sorted false -h $@
}
_la() {
	ls_sorted true -h $@
}

ls_sorted() {
	local show_hidden="$1"

	local sub_dir=false
	if [ ! -z "$3" ]; then
		if [ -f "$3" ]; then
			if [ -d "$3" ]; then
				sub_dir=true
			else
				ls $2 $3
				return
			fi
		else
			ls $2 $3
			return
		fi
		cd "$3"
	fi

	local files="$(ls -A1F $3)"

	local hidden="$(echo "$files" | grep -e "^\.")"
	local normal="$(echo "$files" | grep -ve "^\.")"

	local hidden_d="$(echo "$hidden" | grep "/$" | sed 's/.$//')"
	local normal_d="$(echo "$normal" | grep "/$" | sed 's/.$//')"

	local hidden_s="$(echo "$hidden" | grep "@$" | sed 's/.$//')"
	local normal_s="$(echo "$normal" | grep "@$" | sed 's/.$//')"

	local hidden_p="$(echo "$hidden" | grep "|$" | sed 's/.$//')"
	local normal_p="$(echo "$normal" | grep "|$" | sed 's/.$//')"

	local hidden_e="$(echo "$hidden" | grep "\*$" | sed 's/.$//')"
	local normal_e="$(echo "$normal" | grep "\*$" | sed 's/.$//')"

	local hidden_f="$(echo "$hidden" | grep -ve "[/@*|]$")"
	local normal_f="$(echo "$normal" | grep -ve "[/@*|]$")"

	if $show_hidden; then
		files="$hidden_d $normal_d $hidden_s $normal_s $hidden_p $normal_p $hidden_e $hidden_f "
		files+="$normal_e $normal_f "
	else
		files="$normal_d $normal_s $normal_p $normal_e $normal_f "
	fi

	ls $2 -FUd --color=always $files
	if $sub_dir; then
		cd - >/dev/null
	fi
}

export -f _lll _lla _ll _la

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
	pwd | tr '/' ' ' | xargs -n 1 | head -n -1
}

pwd_full_list() {
	dir_list="$(pwd_list)"
	path=""
	while IFS= read -r line; do
		path="$path/$line"
		echo "$path"
	done <<< "$dir_list"
}

pwd_dot_list() {
	dir_list="$(pwd_list)"
	dir_num="$(wc -l <<< "$dir_list")"
	i=0
	while IFS= read -r line; do
		num_dots="$(($dir_num - $i))"
		num_spaces="$i"
		dots="$(printf '.%.0s' $(seq 0 $num_dots))"
		[ $num_spaces -ne 0 ] \
			&& spaces="$(printf ' %.0s' $(seq 1 $num_spaces))" \
			|| spaces=""
		echo "$spaces$dots $line"
		((i++))
	done <<< "$dir_list"
}

export -f tree_dotfiles pwd_list

move_cursor() {
	[ ${#@} == 2 ] && true; check_error $? nargs
	case $1 in
		u)
			printf "\033[$2A"
			;;
		d)
			printf "\033[$2B"
			;;
		f)
			printf "\033[$2C"
			;;
		b)
			printf "\033[$2D"
			;;
  		s)
			printf "\033[s"
			;;
  		r)
			printf "\033[u"
			;;
		*)
			false; check_error $? arg $1
			;;
	esac
}

print_at() {
	[ ${#@} == 3 ] && true; check_error $? nargs
	move_cursor s 0
	move_cursor u $1
	move_cursor f $2
	printf "$3"
	move_cursor r 0
}

export -f move_cursor print_at
