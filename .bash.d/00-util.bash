#!/usr/bin/env bash

function confirm() {
	printf "Do you want to execute this cmd? (y/n) "
}

check_error() {
	if [ "$1" -ne "0" ]; then
		local desc=""
		case $2 in
			nargs)
				desc="${FUNCNAME[1]}: Invalid number of arguments."
				;;
			arg)
				[ ${#@} == 3 ] && true; check_errs $? nargs
				desc="${FUNCNAME[1]}: Invalid argument $3"
				;;
			*)
				desc="No description."
		esac
		desc=" $desc"

		printf "${RED}Error:${RESET}$desc\n"
		exit $1
	fi
}

export -f check_error confirm
