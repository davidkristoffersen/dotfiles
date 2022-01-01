#!/usr/bin/bash

pkg_local() {
	out="$(dpkg-query -f '${Section}\t'$1'\t${binary:Synopsis}' -W "$1" 2>/dev/null)"
	if [ $? -eq 0 ]; then
		echo -e "$out"
	else
		echo -e "local\t$1" >&2
		return 1
	fi
}

pkg_cache() {
	out="$(apt-cache show "^$1$" 2>/dev/null)"
	if [ $? -eq 0 ] && [ ! -z "$out" ]; then
		section="$(grep -iPo "^section: \K.*" <<<"$out" | head -n 1)"
		desc="$(grep -iPo "^description-en: \K.*" <<<"$out" | head -n 1)"
		echo -e "$section\t$1\t$desc"
	else
		echo -e "cache\t$1" >&2
		return 1
	fi
}

pkg_remote() {
	out="$(aptitude search "^$1$" --disable-columns -F "$(echo -e "%s\t%p\t%d")")"
	if [ $? -eq 0 ]; then
		echo -e "$out"
	else
		echo -e "remote\t$1" >&2
		echo -e "Unknown\t$1\t"
		return 1
	fi
}

child() {
	out="$(pkg_local "$1")"
	[ $? -ne 0 ] && out="$(pkg_cache "$1")"
	[ $? -ne 0 ] && out="$(pkg_remote "$1")"
	echo -e "$out"
}
export -f pkg_local pkg_cache pkg_remote child

gen_table() {
	IFS_bak="$IFS"
	IFS=$'\n'
	names=($1)
	IFS="$IFS_bak"

	table="$(parallel -j4 -k child ::: "${names[@]}" | sort)"
	table="=======\t====\t===========\n$table"
	table="Section\tName\tDescription\n$table"
	echo -e "$(echo -e "$table" | column -t -s $'\t')"
}

gen() {
	[ "$1" == " " ] && post="" || post="$1"
	names="${@:2:$#-1}"

	csv="$(echo "$names" | tr $'\n' ',')"
	lines="$names"
	table="$(gen_table "$names")"

	# echo -e "$csv" >"csv$post.csv"
	# echo -e "$lines" >"lines$post.txt"
	echo -e "$table" >"table$post.txt"
}

main() {
	# names_manual=$(apt-mark showmanual | sort)
	# names_all="$(dpkg-query -f '${binary:Package}\n' -W | sort)"
	# names="$(comm -12 <(echo "$names_all") <(echo "$names_manual"))"
	# names_backup="$(cat lines_old.txt)"

	# gen " " "$names"
	# gen "_all" "$names_all"
	# gen "_backup" "$names_backup"
}

main
