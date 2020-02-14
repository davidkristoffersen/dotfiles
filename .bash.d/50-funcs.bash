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

function lll() {
	ls_sorted false -lh $@
}
function lla() {
	ls_sorted true -lh $@
}
function ll() {
	ls_sorted false -h $@
}
function la() {
	ls_sorted true -h $@
}

function ls_sorted() {
	local show_hidden="$1"
	local sub_dir=false
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
		files="$hidden_d $hidden_s $hidden_p $hidden_e $hidden_f "
	else
		files=""
	fi
	files+="$normal_d $normal_s $normal_p $normal_e $normal_f "

	if [ -d "$3" ]; then
		sub_dir=true
		cd "$3"
	fi
	ls $2 -FUd --color=always $files
	if $sub_dir; then
		cd - >/dev/null
	fi
}

export -f lll lla ll la

function move_cursor() {
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

function print_at() {
	[ ${#@} == 3 ] && true; check_error $? nargs
	move_cursor s 0
	move_cursor u $1
	move_cursor f $2
	printf "$3"
	move_cursor r 0
}

export -f move_cursor print_at
