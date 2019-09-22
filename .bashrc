#!/bin/bash
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
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs
__prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1=""

    local rcol='\[\e[0m\]'
    local red='\[\e[0;31m\]'
    local gre='\[\e[0;32m\]'
    local byel='\[\e[1;33m\]'
    local bblu='\[\e[1;34m\]'
    local bpur='\[\e[1;35m\]'
	local fbla='\[\e[2m\]'

	# Git branch detection
	local branch="$(git branch 2>/dev/null | grep '^*' | colrm 1 2) "
 	if [ "$branch" == " " ]; then
		branch=''
	fi

	local pre="$rcol"
	local post="$rcol "

    PS1+="$pre"

	# Add user and host if it is a ssh session
	if [ ! -z "$SSH_TTY" ]; then
		PS1+="$byel[$rcol\u$rcol"
		PS1+="$fbla@$rcol"
		PS1+="${HOSTNAME%%.*}$byel]$rcol "
	fi

	PS1+="$bpur$branch$rcol"
	PS1+="$bblu\W$rcol "

	# Color based exit status
    if [ $EXIT != 0 ]; then
        PS1+="${red}</3${rcol}"
    else
        PS1+="${gre}<3${rcol}"
    fi

    PS1+="$post"
}

# Enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# Secret exports and aliases
if [ -z "$SSH_TTY" ] && [ -z "$TMUX" ]; then
	. ~/.bash_secrets
    . ~/.bash_profile
fi

# Alias definitions
. ~/.bash_aliases

# Functions
. ~/.bash_funcs

# Cluster exports
if [ ! -z "$SSH_TTY" ]; then
	. ~/.bash_uvcluster
fi
