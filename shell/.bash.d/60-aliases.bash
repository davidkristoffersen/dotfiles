#!/usr/bin/bash

# Navigation
# enable color support of ls and also add handy aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias tree='tree -C'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# Listing
alias lll="exa -ls type --git"
alias lla="exa -las type --git"
alias ll="exa -lGs type --git"
alias la="exa -lGas type --git"
alias l="exa -s type --git"
alias a="exa -as type --git"

alias srcall="source $HOME/.bash_profile"
alias srcbash="source $HOME/.bashrc"
alias bashrc="vim $HOME/.bashrc"
alias bashconfig="vim -p $(echo $HOME/.bashrc $HOME/.bash.d/*.bash)"
alias srcprofile="source $HOME/.profile"
alias profileconfig="vim -p $(echo $HOME/.profile $HOME/.profile.d/*.bash)"
alias vimrc="vim $MYVIMRC"
alias vimhome="cd $DOTFILES_HOME/.vim"
alias vim_plugins="cd $HOME/.vim/bundle"
alias dotfiles="cd $DOTFILES"

alias c='clear'

# Program specific
alias rip='gio trash'
alias lock='i3lock-fancy -pf inconsolata'
alias python='python3'
alias pcloud_start='pcloud > /dev/null 2>&1 &'
alias vless="$PAGER"
