#!/usr/bin/bash

code_style_format() {
	for i in $@; do
		backup_pos="/tmp/clang_format_backup/$(basename $i)$(date +%Y.%m.%d-%H:%M:%S).bak"
		mkdir -p /tmp/clang_format_backup
		mv $i $backup_pos
		cat $backup_pos | clang-format -style="$CLANG_FORMAT_CONFIG" >$i
	done
}

xresource_get() {
	if $XDISPLAY; then
		local _args="$(echo $@ | tr ' ' '.')"
		xrdb -query | grep -i "$_args:" | cut -f 2
	fi
}

evalps1() {
	myprompt=${PS1@P}
	printf '%s\n' "${myprompt//[$'\001'$'\002']/}" | tr '\n' '\0'
}

extract() {
	if [ -f $1 ]; then
		case $1 in
		*.tar.bz2) tar xjf $1 ;;
		*.tar.gz) tar xzf $1 ;;
		*.bz2) bunzip2 $1 ;;
		*.rar) unrar x $1 ;;
		*.gz) gunzip $1 ;;
		*.tar) tar xf $1 ;;
		*.tbz2) tar xjf $1 ;;
		*.tgz) tar xzf $1 ;;
		*.zip) unzip $1 ;;
		*.Z) uncompress $1 ;;
		*.7z) 7z x $1 ;;
		*) echo "'$1' cannot be extracted" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

export -f code_style_format xresource_get evalps1 extract
