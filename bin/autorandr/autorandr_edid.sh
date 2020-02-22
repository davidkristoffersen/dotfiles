#!/usr/bin/env bash

ports="$(autorandr --fingerprint | awk '{ print $1 }' | xargs | tr ' ' '|')"
[[ $1 =~ ($ports) ]]
check_error $? "Usage: $(basename $0) ($ports)"

autorandr --fingerprint | grep -e "^$1" | awk '{ print $2 }'
