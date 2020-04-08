#!/usr/bin/env bash

help() {
	printf "Usage: $(basename $0) [OPTIONS] NAME\n"
	printf "\t-r|--rename:\tRename profile\n"
	printf "\t-f|--force:\t\tForce update profile\n"
	printf "\t-h|--help:\t\tPrint this help message.\n"
	exit
}

while (( "$#" )); do
	case "$1" in
		-r|--rename)
			[ ${#@} -gt 1 ] && rename=$2 || check_error 1 argv $1 $2
			shift; shift
			;;
		-f|--force)
			force="--force"
			shift
			;;
		-h|--help)
			help
			;;
		*)
			name="$1"
			break
			;;
	esac
done
test "$name"; check_error $? argv name

arandr
if test $rename; then
	autorandr -r $rename; check_error $? line $LINENO
fi

autorandr $force -s $name; check_error $? line $LINENO
autorandr_config.sh $name; check_error $? line $LINENO
