#!/usr/bin/env bash
# Setup installation of dotfiles

dotfiles="$HOME/dotfiles"

# Clone the git repository
printf "git clone https://github.com/davidkristoffersen/dotfiles.git $dotfiles\n"
git clone https://github.com/davidkristoffersen/dotfiles.git $dotfiles
[ $? -ne 0 ] && exit

printf "cd $dotfiles\n"
cd $dotfiles
[ $? -ne 0 ] && exit

printf "./install.sh\n"
./install.sh
