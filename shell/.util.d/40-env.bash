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
$XDISPLAY && $SHELL_WSL &&
	SHELL_WSLG=true ||
	SHELL_WSLG=false

if $SHELL_WSL && [ -z "$WIN_HOME" ]; then
	local root="$(win_cmd_out "cd / && cd")"
	win_set_env "WIN_ROOT" "$root"
	win_set_env "WIN_HOME" "%USERPROFILE%"
	win_set_env "WIN_USERNAME" "%USERNAME%"
	win_cmd "set WSLENV=WT_SESSION:WT_PROFILE_ID:WIN_ROOT/p:WIN_HOME/p:WIN_USERNAME"
	win_cmd "setx WSLENV WIN_ROOT/p:WIN_HOME/p:WIN_USERNAME"
	export WIN_HOME="$(win_get_env USERPROFILE)"
	export WIN_USERNAME="$(win_get_env USERNAME)"
	export WIN_ROOT="$(wslpath -u "$root")"
fi

if $SHELL_WSL; then
	WIN_DOWN="$WIN_HOME/Downloads"
	WIN_DOCS="$WIN_HOME/Documents"
	WIN_PICS="$WIN_HOME/Pictures"
	WIN_VIDS="$WIN_HOME/Videos"
	WIN_MUSIC="$WIN_HOME/Music"
fi

export SHELL_SH SHELL_INTERACTIVE SHELL_LOGIN SSH XDISPLAY SHELL_WSL SHELL_WSLG

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
