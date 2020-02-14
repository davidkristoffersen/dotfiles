#!/usr/bin/env bash

function confirm() {
	printf "Do you want to execute this cmd? (y/n) "
}

check_error() {
	if [ "$1" -ne "0" ]; then
		local error="$1"
		shift
		local desc="\tFile: ${BASH_SOURCE[1]}\n\tFunc: ${FUNCNAME[1]}"
		case $1 in
			nargs)
				desc+="\n\tDesc: Invalid number of arguments."
				;;
			arg)
				[ ${#@} -ne 1 ] && local arg="$2" || local arg="(Missing argument)"
				desc+="\n\tDesc: Invalid argument $arg"
				;;
			file)
				[ ${#@} -ne 1 ] && local arg="$2" || local arg="(Missing argument)"
				desc+="\n\tDesc: Error in $arg"
				;;
			*)
				[ ${#@} -ne 0 ] && desc+="\n\tDesc: $@"
		esac

		printf "${RED}Error:${RESET}\n$desc\n"
		exit $error
	fi
}

export -f check_error confirm
