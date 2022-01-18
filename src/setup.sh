#!/usr/bin/bash

# Apt requirements
req_apt() {
	packages="$(check_req apt requirements.apt)"
	install_req apt "$packages"

}

# Pip requirements
req_pip() {
	packages="$(check_req pip requirements.pip)"
	install_req pip "$packages"
}

check_req() {
	local packages=''
	while IFS= read -r line || [ -n "$line" ]; do
		if [ "$1" == "apt" ]; then
			dpkg -s "$line" 1>/dev/null 2>/dev/null
		elif [ "$1" == "pip" ]; then
			pip list | grep -i "^$line\s" 1>/dev/null 2>/dev/null
		fi

		if [ $? -ne 0 ]; then
			packages="$packages $line"
		fi
	done <"$2"
	echo "$packages" | xargs
}

install_req() {
	if [ ! -z "$2" ]; then
		echo -e "\nMissing $1 packages: $2"
		echo "Install(Y/n)?:" | tr $'\n' ' '
		read choice
		if [[ "$choice" =~ ^(y|Y|yes|)$ ]]; then
			if [ "$1" == "apt" ]; then
				echo -e "\nsudo apt install $2"
				sudo apt install $2
			elif [ "$1" == "pip" ]; then
				echo -e "\npip install $2"
				pip install $2
			fi
		fi
	fi
}

# Setup autocomplete for python setup script
autocomplete() {
	eval "$(register-python-argcomplete ./setup.py)"
}

main() {
	pushd . >/dev/null
	cd "$(dirname ${BASH_SOURCE[0]})"

	req_apt
	req_pip
	autocomplete

	popd >/dev/null
}

main
