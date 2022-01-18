#!/usr/bin/bash

#
# ENVIRONMENT STATUS
#

# Is the shell a sh environment
[ "$0" == "sh" ] &&
	SHELL_SH=true ||
	SHELL_SH=false

# Is the shell interactive
[ ! -z "$(echo $- | grep i)" ] &&
	SHELL_INTERACTIVE=true ||
	SHELL_INTERACTIVE=false

# Is the shell a login shell
[ ! -z "$(shopt login_shell)" ] &&
	SHELL_LOGIN=true ||
	SHELL_LOGIN=false

# Is the shell a ssh environment
[ ! -z "$(pstree -ps $$ | grep sshd)" ] &&
	SSH=true ||
	SSH=false

# Is X active
xhost >&/dev/null &&
	XDISPLAY=true ||
	XDISPLAY=false

# Is the os based on wsl
[ ! -z "$(uname -r | grep -ie "wsl2$")" ] &&
	SHELL_WSL=true ||
	SHELL_WSL=false

# Does wsl have gui support
false && $SHELL_WSL &&
	SHELL_WSLG=true ||
	SHELL_WSLG=false

# Windows home path
# && WIN_HOME="$(wslpath "$(wslvar USERPROFILE)")" \
$SHELL_WSL &&
	WIN_HOME="/mnt/c/Users/divad" ||
	WIN_HOME=""

# Windows username
$SHELL_WSL &&
	WIN_USERNAME="$(echo "$WIN_HOME" | xargs -I {} basename {})" ||
	WIN_USERNAME=""

export SHELL_SH SHELL_INTERACTIVE SHELL_LOGIN SSH XDISPLAY SHELL_WSL SHELL_WSLG WIN_HOME WIN_USERNAME

#
# COLORS
#

set_colors() {
	# Colors
	declare -A colors=([black]=30
		[red]=31
		[green]=32
		[yellow]=33
		[blue]=34
		[magenta]=35
		[cyan]=36
		[white]=37
	)
	local pre='\033['
	export RESET="${pre}m"
	export BOLD="${pre}1m"
	export FAINT="${pre}2m"
	export ITALIC="${pre}3m"
	export UNDERLINE="${pre}4m"
	export CROSSEDOUT="${pre}9m"

	# Prompt specific
	export PRESET="\[${pre}m\]"
	export PBOLD="\[${pre}1m\]"
	export PFAINT="\[${pre}2m\]"
	export PITALIC="\[${pre}3m\]"
	export PUNDERLINE="\[${pre}4m\]"
	export PCROSSEDOUT="\[${pre}9m\]"

	for key in "${!colors[@]}"; do
		eval "export ${key^^}=\"${pre}${colors[$key]}m\""
		eval "export B${key^^}=\"${pre}1;${colors[$key]}m\""
		eval "export F${key^^}=\"${pre}2;${colors[$key]}m\""
		eval "export I${key^^}=\"${pre}3;${colors[$key]}m\""

		# Prompt specific
		eval "export P${key^^}=\"\[${pre}${colors[$key]}m\]\""
		eval "export PB${key^^}=\"\[${pre}1;${colors[$key]}m\]\""
		eval "export PF${key^^}=\"\[${pre}2;${colors[$key]}m\]\""
		eval "export PI${key^^}=\"\[${pre}3;${colors[$key]}m\]\""
	done
}

set_colors

#
# DOTFILES REPO STATUS
#

[ ! -z "$(
	cd $DOTFILES
	git submodule summary
	cd - >&/dev/null
)" ] &&
	SUBMODULE_INIT=true ||
	SUBMODULE_INIT=false
