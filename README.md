# Linux dotfiles

This repository contain all my Linux configuration files and scripts

## Install

**Set repo path:**

```bash
$ dotfiles="$HOME/dotfiles"
```

**Clone the git repository:**

```bash
$ git clone --recurse-submodules -j8 https://github.com/davidkristoffersen/dotfiles.git $dotfiles
```

**Source the bash setup script:**

This script does the following:

- Installs apt package requirements
- Installs pip package requirements
- Enable command autocompletion for python setup script

```bash
$ cd $dotfiles/src
$ source setup.sh
```

**Run the python setup script:**

This script installs all dotfiles

```bash
$ ./setup.py -w
```
