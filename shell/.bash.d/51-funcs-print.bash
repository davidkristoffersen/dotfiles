#!/usr/bin/bash

move_cursor() {
	[ ${#@} == 2 ] && true
	check_error $? nargs
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
		false
		check_error $? arg $1
		;;
	esac
}

print_at() {
	[ ${#@} == 3 ] && true
	check_error $? nargs
	move_cursor s 0
	move_cursor u $1
	move_cursor f $2
	printf "$3"
	move_cursor r 0
}

print_ascii_list() {
	for ((i = 0; i < 48; i++)); do
		for ((j = 0; j < 48; j++)); do
			echo -e "[${i}][${j}] -> " | tr '\n' '\0'
			for ((k = 31; k < 48; k++)); do
				echo -e "${k}:\e[${i};${j};${k}mText\e[m, " | tr '\n' '\0'
			done
			echo
		done
	done
}

print_ascii_wave() {
	b() { test $1 && echo $1 || echo $2; }
	r="{$(b $1 0)..255..$(b $4 16)} {255..$(b $1 0)..$(b $4 16)}"
	g="{$(b $2 0)..255..$(b $5 16)} {255..$(b $2 0)..$(b $5 16)}"
	b="{$(b $3 0)..255..$(b $6 4)} {255..$(b $3 0)..$(b $6 4)}"
	for i in $(eval echo "$r"); do
		for j in $(eval echo "$g"); do
			for k in $(eval echo "$b"); do
				echo -en "\e[38;2;${i};${j};${k}m#\e[m"
			done
			echo
		done
	done
}

unix_time() {
	arr="$(date "+%s")"
	new=""
	for ((i = 0; i < ${#arr}; i++)); do new="$new$(echo -e "${arr:$i:1}" | tr '\n' ' ')"; done
	echo -e "$new" | figlet
}

clock() {
	while true; do
		declare -a arr=("H" " : " "M" " : " "S" "%F %T .%3N")
		col="\e[38;2;200;200;0m"
		var=""

		for i in "${!arr[@]}"; do
			if [ "$i" == "1" ] || [ "$i" == "3" ]; then
				var="${var} ${arr[$i]} "
			elif [ "$i" == "0" ] || [ "$i" == "2" ] || [ "$i" == "4" ]; then
				for j in {0..1}; do
					if [ "$j" == "0" ]; then
						var="${var}$(date +"%${arr[$i]}" | grep -Pio "^\d") "
					else var="${var}$(date +"%${arr[$i]}" | grep -Pio "\d$")"; fi
				done
			else
				tmp="$(date +"${arr[$i]}" | grep -Pio "\d{3}$")"
				var="${var} ."
				for j in {2..0}; do
					var="${var} $(echo $tmp | grep -Pio "\d(?=\d{$j}$)")"
				done
			fi
		done
		var="$col$(echo $var | figlet -w 100)"
		var="$var\e[m"
		clear
		echo -e "$var"
		# sleep 0.1
	done
}

export -f move_cursor print_at print_ascii_list print_ascii_wave
