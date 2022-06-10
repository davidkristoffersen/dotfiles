#!/usr/bin/bash

#
# HELP UTILITY FUNCTIONS
#

help_check() {
	while [ $# -gt 0 ]; do
		if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
			true
			return
		fi
		shift 1
	done
	false
}

help_print() {
	help_check $@ && _help_print_help && return 1
	local script="$1"
	shift

	echo -e "${YELLOW}USAGE:$RESET"
	echo -e "\t$script [OPTIONS]"
	echo
	echo -e "${YELLOW}OPTIONS:$RESET"

	local out=""
	local option=""
	local split=$'\t'
	local IFS_bak="$IFS"

	while [ $# -gt 0 ]; do
		option="$1"
		shift
		IFS=$split
		option="$(help_option $option)"
		IFS="$IFS_bak"
		out="$out\n$option"
	done
	echo -e "$out" | column -t -s $'\t' -o $'\t'
	# exit 2
}

help_option() {
	help_check $@ && _help_option_help && return 1
	# Description extention
	if [ $# -eq 1 ]; then
		echo -e "\t\t$1"
	# Only short flag
	elif [ $# -eq 2 ]; then
		echo -e "\t$GREEN-$1$RESET\t$2"
	# Only long flag
	elif [ $# -eq 3 ] && [ $1 == ' ' ]; then
		echo -e "\t    $GREEN--$2$RESET\t$3"
	# Two flags
	elif [ $# -eq 3 ]; then
		echo -e "\t$GREEN-$1$RESET, $GREEN--$2$RESET\t$3"
	fi
}

help_test() {
	help_print "script.sh" \
		"i	init	Initialize script config" \
		"p	print	script files" \
		"c	compile	binary files" \
		"C	no-compile	Do not compile binary files" \
		"m	message	A long message that need to span" \
		"Over multiple line. The reason for this is" \
		"because the message tests multiline option print" \
		"s	Single only flag" \
		" 	long	Long only flag" \
		"h	help	Print this help message"
}

export -f help_check help_print help_option help_test
