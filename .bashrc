 # ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
unset color_prompt force_color_prompt

export PS1="\[\e[1;34m\]\W\[\e[m\] \[\e[2m\]\t\[\e[m\]\[\e[1;38;2;200;80;200m\]\`get_git_branch\`\[\e[m\]\[\e[1;38;2;200;200;0m\] \u \[\e[38;2;200;40;70m\]<3\[\e[m\] "

function get_git_branch() {
	branch="$(git branch 2>/dev/null | grep '^*' | colrm 1 2)"
	if [ -z "$branch" ]; then
		echo ''
	else
		echo -e " $branch"
	fi
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'



# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export CLANG_FORMAT_CONFIG='{
 ColumnLimit: 500,
 UseTab: ForIndentation,
 TabWidth: 1,
 IndentWidth: 1,
 AllowShortFunctionsOnASingleLine: false,
 BreakBeforeBraces: Custom,
 BraceWrapping: {
  BeforeElse: true,
 AfterEnum: true,
 }
}'
function code-style-format() {
	for i in $@; do
		backup_pos="/tmp/clang_format_backup/$(basename $i)$(date +%Y.%m.%d-%H:%M:%S).bak"
		mkdir -p /tmp/clang_format_backup
		mv $i $backup_pos
		cat $backup_pos | clang-format -style="$CLANG_FORMAT_CONFIG" > $i
	done
}

function evalps1() {
	myprompt=${PS1@P}; printf '%s\n' "${myprompt//[$'\001'$'\002']}" | tr '\n' '\0'
}

function format_patch() {
	git format-patch --base=$1 $1..$2 --stdout > "../patches/patch-$1-$2.patch";
}

function toggle_scroll {
	# xinput list | egrep "slave.*pointer" | grep -v XTEST | sed -e 's/^.*id=//' -e 's/\s.*$//'
	tog="$(xinput get-button-map 22)"
	tog="${tog:6:1}"
	if [ "$tog" == "4" ]; then
		xinput set-button-map 22 1 2 3 5 4 6 7
		xinput set-button-map 17 1 2 3 5 4 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
		xinput set-button-map 24 1 2 3 5 4 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
	else
		xinput set-button-map 22 1 2 3 4 5 6 7
		xinput set-button-map 17 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
		xinput set-button-map 24 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
	fi
}

function android_react() {
	cd /home/david/studies/semester_6/inf_2900/app/app
	$ANDROID_HOME/emulator/emulator @pixel2xl &
	npm start -- -a
}

function update_gitlab-runner() {
	sudo gitlab-runner stop
	sudo wget -O /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
	sudo chmod +x /usr/local/bin/gitlab-runner
	sudo gitlab-runner start
}

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias srcbash='source ~/.bashrc'
alias bashrc='vim ~/.bashrc'
alias vimrc='vim $MYVIMRC'
alias ed_osucli='vim /home/david/scripts/osu/osucli.py'
alias c='clear'
alias rip='gio trash'
alias pcloud_start='pcloud > /dev/null 2>&1 &'
alias lock='i3lock-fancy -pf inconsolata'
alias python='python3'

alias mat_1004='cd /home/david/studies/semester_6/mat_1004'
alias inf_2900='cd /home/david/studies/semester_6/inf_2900'
alias inf_3910='cd /home/david/studies/semester_6/inf_3910'
alias inf_2201='cd /home/david/studies/semester_6/ta/inf_2201'
alias inf_2201_pre='cd /home/david/studies/semester_6/ta/inf_2201/inf-2201/precepts/2019/'
alias inf_2201_post='cd /home/david/studies/semester_6/ta/inf_2201/inf-2201/postcode/'
alias inf_ta='cd /home/david/studies/semester_6/ta/inf_2201/correcting/TA'
alias inf_2201_old='cd /home/david/studies/semester_4/inf_2201'
alias vim_29_main='vim -p App.js src/screens/Login.js src/navigation/*.js'
alias vim_29_screens='vim -p src/screens/**/*.js'
alias vim_29_extra='vim -p src/store/*.js src/modules/*.js'
alias inf_2700='cd /home/david/studies/semester_7/inf_2700'
alias inf_2700_old='cd /home/david/studies/semester_5/inf_2700'
alias inf_3200='cd /home/david/studies/semester_7/inf_3200'
alias inf_3201='cd /home/david/studies/semester_7/inf_3201'

export LATEX_HEADER='/home/david/config/template.latex'
export MDPDF_SCRIPT='/home/david/scripts/markdownpdf/mdpdf.py'

export GITHUB_TOKEN='f8c29a265648b34a1a856b697bacc32cb7b8a2ff'
export GITHUB_API_URL='api.github.com'
export ORG_NAME='uit-inf-2201-s19'

export GITLAB_TOKEN='qezUXzgbzjUz-Qi3f8DF'

export SLACK_UIT_INF_2201_S19_TOKEN='xoxp-522756084819-523303157093-529048452947-fb478e788487af0c1ecdd44f1f92697b'

export GOOGLE_SHEETS_TOKEN='AIzaSyDaLRSDiuY9c6LT6JJuvDzCKPYA3YX_NGE'
export GOOGLE_SHEETS_AUTH_CODE='4/2QCx3Mm4d4uJmmJTGbfFxGX1hEp4Uhr-z0Ivqq7emyS3mDwvgRttXVo'
export GOOGLE_SHEETS_CLIENT_ID='312664296559-3i9hboag2dvinc1njqgqs97l28cug5dt.apps.googleusercontent.com'
export GOOGLE_SHEETS_CLIENT_SECRET='W263OR7XR8J9gVP-Kcsg6Ha4'
export GOOGLE_SHEETS_SCOPES='https://googleapis.com/auth/spreadsheets.readonly'
export GOOGLE_SHEETS_REFRESH_TOKEN='1/Z0cEThuIzP_h8qMPOixT6hG5UxrNkb17C4wg3ir4GJIBJypGYxX7n9hW4nJ-kTTE'

export BROWSER="/usr/bin/firefox"
export SYSTEMD_EDITOR="vim"
export MYVIMRC="/home/david/.vimrc"
tabs 4

NPM_PACKAGES=/home/david/.npm-packages
PATH="$NPM_PACKAGES/bin:$PATH"

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator

alias emu=$ANDROID_HOME/emulator/emulator
alias emu-def='$ANDROID_HOME/emulator/emulator @pixel2xl'
alias emu-menu='adb shell input keyevent 82'

echo "setleds: Error reading current flags setting. Maybe you are not on the console?: ioctl KDGKBLED: Inappropriate ioctl for device"
# export GOOGLE_SHEETS_ACCESS_TOKEN='ya29.GluYBkxhmCHrXOejiEQGf95fI7imH5phnoF__tit2EAfkHSp8LslumnmqIdApjfC6XeCKP_HVTlK0HprsITMjn00qtH5sULk3WiCCQV7FQwAqnNiWyLrLIr39B_S'
