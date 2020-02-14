#!/usr/bin/env bash

function code-style-format() {
	for i in $@; do
		backup_pos="/tmp/clang_format_backup/$(basename $i)$(date +%Y.%m.%d-%H:%M:%S).bak"
		mkdir -p /tmp/clang_format_backup
		mv $i $backup_pos
		cat $backup_pos | clang-format -style="$CLANG_FORMAT_CONFIG" > $i
	done
}

function evalps1() {
	myprompt=${PS1@P}; printf '%s\n' "${myprompt//[$'\001'$'\002']}" | tr '\n' '\0'
}

function format_patch() {
	git format-patch --base=$1 $1..$2 --stdout > "../patches/patch-$1-$2.patch";
}

function hostname_master() {
	name="$1"
	tracepath -b 129.242.16.30 | grep "$name" | grep -e '^ 1:'
}

function move_cursor() {
	[ ${#@} == 2 ] && true; check_errs $? nargs
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
			false; check_errs $? arg $1
			;;
	esac
}

function print_at() {
	[ ${#@} == 3 ] && true; check_errs $? nargs
	move_cursor s 0
	move_cursor u $1
	move_cursor f $2
	printf "$3"
	move_cursor r 0
}

export -f move_cursor print_at
