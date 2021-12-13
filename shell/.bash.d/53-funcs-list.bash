#!/usr/bin/bash

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
