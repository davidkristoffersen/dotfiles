#!/usr/bin/env bash

function confirm() {
	printf "Do you want to execute this cmd? (y/n) "
}

check_error() {
	if [ "$1" -ne "0" ]; then
		local error="$1"
		shift
		local desc=" ${FUNCNAME[1]}"
		case $1 in
			nargs)
				desc=": Invalid number of arguments."
				;;
			arg)
				[ ${#@} -ne 1 ]; check_errs $? nargs
				desc=": Invalid argument $2"
				;;
			*)
				if [ ${#@} -gt 1 ]; then
					shift
					desc=": $@"
				else
					desc=": No description."
				fi
		esac

		printf "${RED}Error:${RESET}$desc\n"
		exit $error
	fi
}

export -f check_error confirm
