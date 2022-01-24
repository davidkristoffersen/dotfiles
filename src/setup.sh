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
	xdg_bin="$HOME/.local/bin"
	mkdir -p "$xdg_bin"
	for line in $1; do
		if [ "$line" == "pcloud" ]; then
			echo -e "\nInstalling $line"
			pcloud_url="https://www.pcloud.com/how-to-install-pcloud-drive-linux.html?download=electron-64"
			pcloud_out="pcloud"
			echo "Open \"$pcloud_url\" in your browser"
			echo "Move the file "$pcloud_out" into this folder"
			echo "Continue(Y/n)?:" | tr $'\n' ' '
			read choice
			if [[ "$choice" =~ ^(y|Y|yes|)$ ]]; then
				echo "cp \"$pcloud_out\" \"$xdg_bin\""
				cp "$pcloud_out" "$xdg_bin"
				echo "$xdg_bin/$pcloud_out &"
				$xdg_bin/$pcloud_out &
				echo "rm -f $pcloud_out"
				rm -f $pcloud_out
			fi
		elif [ "$line" == "exa" ]; then
			echo -e "\nInstalling $line"
			exa_version="v0.10.1"
			exa_url="https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-$exa_version.zip"
			exa_zip="exa.zip"
			exa_unzip="exa"
			exa_bin="exa/bin/exa"
			exa_dst="$xdg_bin"

			echo "mkdir -p exa"
			mkdir -p exa
			echo "wget $exa_url -O $exa_zip"
			wget $exa_url -O $exa_zip
			echo "unzip $exa_zip -d $exa_unzip"
			unzip $exa_zip -d $exa_unzip
			echo "mkdir -p $exa_dst"
			echo "mv $exa_bin $exa_dst"
			mv $exa_bin $exa_dst
			echo "rm -f $exa_zip"
			rm -f $exa_zip
			echo "rm -rf $exa_unzip"
			rm -rf $exa_unzip
		fi
	done
}

# Setup autocomplete for python setup script
autocomplete() {
	eval "$(register-python-argcomplete3 ./setup.py)"
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
