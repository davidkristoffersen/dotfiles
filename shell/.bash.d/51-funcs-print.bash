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

hex2rgb() {
	printf "%d;%d;%d" 0x${1:0:2} 0x${1:2:2} 0x${1:4:2}
}

rgb_text() {
	echo -en "\x1b[38;2;$1m$2\x1b[m"
}

rgb_back() {
	echo -en "\x1b[48;2;$1m$2\x1b[m"
}

print_ansi() {
	log() {
		local rgb="$(hex2rgb "$3")"
		local back="$(rgb_back "$rgb" "   ")"
		local pre="$(rgb_text "$rgb" "$1\t$2")"
		local suf="$(rgb_text "$rgb" "#$3\t$rgb\t$4")"
		echo -e "$pre\t$back\t$suf"
	}
	log_normal() {
		log "0" "Black" "000000" "30"
		log "1" "Red" "c71e00" "31"
		log "2" "Green" "00c203" "32"
		log "3" "Yellow" "c6c500" "33"
		log "4" "Blue" "6775b8" "34"
		log "5" "Purple" "ca31c6" "35"
		log "6" "Cyan" "07afc8" "36"
		log "7" "White" "c7c7c7" "37"
	}

	log_bright() {
		log "8" "Black" "686868" "90"
		log "9" "Red" "ff6e6a" "91"
		log "10" "Green" "60fa68" "92"
		log "11" "Yellow" "fefb68" "93"
		log "12" "Blue" "b3b5fe" "94"
		log "13" "Purple" "ff78ff" "95"
		log "14" "Cyan" "5dd7da" "96"
		log "15" "White" "ffffff" "97"
	}

	echo -e "Normal colors"
	log_normal | column -N "No.,Name,Color,Hex,RGB,4-Bit" -ts $'\t'

	echo -e "\nBright colors"
	log_bright | column -N "No.,Name,Color,Hex,RGB,4-Bit" -ts $'\t'
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

print_ansi_list() {
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

print_ansi_wave() {
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

export -f move_cursor hex2rgb rgb_back rgb_text print_at print_ansi_list print_ansi_wave
