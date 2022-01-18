# Linux dotfiles

This repository contain all my Linux configuration files and scripts

## Install

### **Set repo path**

```bash
$ dotfiles="$HOME/dotfiles"
```

### **Clone the git repository**

```bash
$ git clone --recurse-submodules -j8 https://github.com/davidkristoffersen/dotfiles.git $dotfiles
```

### **Update and upgrade package repositories**

- Apt

```bash
$ sudo apt update
$ sudo apt upgrade
```

### **Source the bash setup script**

This script does the following:

- Installs package requirements
- Enable command autocompletion for python setup script

```bash
$ cd $dotfiles/src
$ source setup.sh
```

### **Run the python setup script**

This script installs all dotfiles

```bash
$ ./setup.py -w
```

### **Restart terminal for changes to take effect**
