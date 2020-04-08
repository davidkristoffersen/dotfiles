#!/usr/bin/env bash

confirm() {
	printf "Do you want to execute this cmd? (y/n) "
}

check_error() {
	if [ "$1" -ne "0" ]; then
		local error="$1"
		shift
		local desc="\tFile: ${BASH_SOURCE[1]}\n\tFunc: ${FUNCNAME[1]}"
		echo $@, $2
		while (( "$#" )); do
			case "$1" in
				nargs)
					desc+="\n\tDesc: Invalid number of arguments."
					shift
					;;
				arg)
					[ ${#@} -gt 1 ] && local arg="$2" && shift || local arg="(Missing argument)"
					desc+="\n\tDesc: Invalid argument $arg"
					shift
					;;
				file)
					[ ${#@} -gt 1 ] && local arg="$2" && shift || local arg="(Missing argument)"
					desc+="\n\tDesc: Error in $arg"
					shift
					;;
				line)
					[ ${#@} -gt 1 ] && local arg="$2" && shift || local arg="(Missing argument)"
					desc+="\n\tLine: $arg"
					shift
					;;
				*)
					[ ${#@} -ne 0 ] && desc+="\n\tDesc: $@"
					break
			esac
		done

		printf "${RED}Error: $error${RESET}\n$desc\n"
		exit $error
	fi
}

export -f check_error confirm
