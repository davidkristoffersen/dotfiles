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

# Other requirements that is not in public repositories
req_other() {
	packages="$(check_req other requirements.other)"
	install_req other "$packages"
}

check_req() {
	local packages=''
	while IFS= read -r line || [ -n "$line" ]; do
		if [ "$1" == "apt" ]; then
			dpkg -s "$line" 1>/dev/null 2>/dev/null
		elif [ "$1" == "pip" ]; then
			pip list | grep -i "^$line\s" 1>/dev/null 2>/dev/null
		elif [ "$1" == "other" ]; then
			command -v "$line" 1>/dev/null 2>/dev/null
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
			elif [ "$1" == "other" ]; then
				install_other "$2"
			fi
		fi
	fi
}

install_other() {
	for line in $1; do
		if [ "$line" == "pcloud" ]; then
			echo -e "\nInstalling $line"
			pcloud_url="https://www.pcloud.com/how-to-install-pcloud-drive-linux.html?download=electron-64"
			pcloud_out="pcloud.bin"
			echo "wget $pcloud_url -O $pcloud_out"
			wget $pcloud_url -O $pcloud_out
			echo "chmod +x $pcloud_out"
			chmod +x $pcloud_out
			echo "./$pcloud_out"
			./$pcloud_out
			echo "rm -f $pcloud_out"
			rm -f $pcloud_out
		elif [ "$line" == "exa" ]; then
			echo -e "\nInstalling $line"
			exa_version="v0.10.1"
			exa_url="https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-$exa_version.zip"
			exa_out="exa.zip"
			exa_unzipped=""
			echo "wget $exa_url -O $exa_out"
			wget $exa_url -O $exa_out
			echo "unzip $exa_out"
			unzip $exa_out
			echo "mv exa-linux-x86_64 $HOME/.local/bin"
			mv exa-linux-x86_64 $HOME/.local/bin
			echo "rm -f $exa_out"
			rm -f $exa_out
		fi
	done
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
	req_other
	autocomplete

	popd >/dev/null
}

main
