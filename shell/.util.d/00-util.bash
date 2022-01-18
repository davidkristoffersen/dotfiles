#!/usr/bin/bash

confirm() {
	printf "Do you want to execute this cmd? (y/n) "
}

check_error_help() {
	printf "Usage: check_error error_code [OPTIONS] [DESCRIPTION]\n"
	printf "\tnargs:\tInvalid number of arguments\n"
	printf "\targ:\tInvalid argument (arg)\n"
	printf "\targv:\tInvalid argument value (arg value)\n"
	printf "\tfile:\tError in (file)\n"
	printf "\tline:\tLine number (line)\n"
	printf "\thelp:\tPrint this help message.\n"

	if [ "$1" != "true" ]; then
		exit $error
	fi
}

check_error() {
	if [ "$#" -eq "0" ]; then
		check_error_help true
		return
	fi
	if [ "$1" -ne "0" ]; then
		local error="$1"
		shift
		local desc="\tFile: ${BASH_SOURCE[1]}\n\tFunc: ${FUNCNAME[1]}"
		while (("$#")); do
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
			argv)
				if [ ${#@} -gt 2 ]; then
					local arg="$2" && local val="$3"
					shift && shift
				elif [ ${#@} -eq 2 ]; then
					local arg="$2"
					shift
					local val="(Missing value)"
				else
					local arg="(Missing argument)"
					local val="(Missing value)"
				fi
				desc+="\n\tDesc: Invalid argument value $arg=$val"
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
			help)
				check_error_help $error
				;;
			*)
				[ ${#@} -ne 0 ] && desc+="\n\tDesc: $@"
				break
				;;
			esac
		done

		printf "${RED}Error: $error${RESET}\n$desc\n"
		exit $error
	fi
}

export -f check_error confirm check_error_help
