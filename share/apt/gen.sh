#!/usr/bin/bash

pkg_local() {
	out="$(dpkg-query -f '${Section}\t'$1'\t${binary:Synopsis}' -W "$1" 2>/dev/null)"
	if [ $? -eq 0 ] && [ "$(awk -F "\t" '{print $NF}' <<<"$out")" != "(no description available)" ]; then
		echo -e "$out"
		echo -e "local\t$1" 1>&2
	else
		return 1
	fi
}

pkg_cache() {
	out="$(apt-cache show "^$1$" 2>/dev/null)"
	if [ $? -eq 0 ] && [ ! -z "$out" ] && [ "$(tail -n 1 <<<"$out" | head -c 3)" == "N:" ]; then
		section="$(grep -iPo "^section: \K.*" <<<"$out" | head -n 1)"
		desc="$(grep -iPo "^description-en: \K.*" <<<"$out" | head -n 1)"
		echo -e "$section\t$1\t$desc"
		echo -e "cache\t$1" 1>&2
	else
		return 1
	fi
}

pkg_remote() {
	out="$(aptitude search "^$1$" --disable-columns -F "$(echo -e "%s\t%p\t%d")")"
	if [ $? -eq 0 ]; then
		if $(pkg_in_remote "$1"); then
			echo -e "$out"
			echo -e "remote\t$1" 1>&2
		else
			echo -e "Unknown\t$1" 1>&2
			echo -e "Unknown/$out"
		fi
	else
		echo -e "Unknown\t$1" 1>&2
		echo -e "Unknown\t$1\t"
		return 1
	fi
}

pkg_in_remote() {
	out="$(apt search "^$1$" 2>/dev/null)"
	[ $? -eq 0 ] && [ ! -z "$out" ] && [ "$(tail -n 1 <<<"$out" | head -c 3)" != "N:" ]
}

child() {
	out="$(pkg_local "$1")"
	local_err="$?"
	[ $local_err -ne 0 ] && out="$(pkg_cache "$1")"
	[ $? -ne 0 ] && [ $local_err -ne 0 ] && out="$(pkg_remote "$1")"
	echo -e "$out"
}
export -f pkg_local pkg_cache pkg_remote pkg_in_remote child

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
	dir="$1"
	post="_$1"
	names="${@:2:$#-1}"
	unknown_pkgs=""

	table="$(gen_table "$names")"
	unknown="$(grep -e "^Unknown" <<<"$table" | awk '{print $2}' | xargs -n 1)"
	lines="$(comm -23 <(sort <<<"$names") <(echo -e "$unknown"))"
	csv="$(tr $'\n' ',' <<<"$lines"| sed 's/,$//')"

	mkdir -p "$dir"
	echo -e "$csv" >"$dir/csv$post.csv"
	echo -e "$lines" >"$dir/lines$post.txt"
	echo -e "$table" >"$dir/table$post.txt"
}

main() {
	# names_manual=$(apt-mark showmanual | sort)
	# names_all="$(dpkg-query -f '${binary:Package}\n' -W | sort)"
	# names="$(comm -12 <(echo "$names_all") <(echo "$names_manual"))"
	names_history="$(grep -Po '^Commandline: apt install \K.*' /var/log/apt/history.log | xargs -n 1 | uniq | sort)"

	# gen "intersect" "$names"
	# gen "all" "$names_all"
	gen "history" "$names_history"
}

main
