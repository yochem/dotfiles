# `/Users/Yochem | /home/yochem`

My modular configuration manager for MacOS and Linux.

## Screenshots
![img](https://user-images.githubusercontent.com/23235841/63441128-38638a80-c431-11e9-8e42-32f6965589aa.png)

I try to comply to the [XDG
standard](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
as much as possible. My $HOME is `chmod -w`'d lol.

Config files      | Installed to
------------------|-----------------
`config/*`        | `XDG_CONFIG_HOME`
`data/*`          | `XDG_DATA_HOME`
`bin/*`           | Normally `~/.local/bin`, but specified in the Makefile
`home/*`          | `~` (looking at you, Bash)

## Installation

This repository can be cloned to any location on your computer. The dotfiles
are managed using a shell script ([`dot.sh`](./dot.sh)). This makes the
configuration modular and allows me to install only the configuration from the
programs I need at that moment.

### Full installation

```
git clone https://github.com/yochem/dotfiles.git
cd dotfiles
./dot.sh */*
```

### `dot.sh` script
```
Usage: dot.sh [sync|track|clean] [FILE...]
       dot.sh --help

Manage dotfiles. Either sync (from this repo to your dotfile directories) or
Start tracking (from your dotfile directories to this repository) your dotfiles.

COMMANDS
	sync		Symlinks file from this repository to your dotfile directories
	track		Moves dotfile to this repository and starts sync
	clean		Removes dotfile, but only if it exists in this repository

FILES
	Files that should be synced/tracked/cleaned. Use glob patterns for easy
	syncing of many files. The * in the root directory will only match the
	dotfile directories: config, data, home, bin
```

## Why?
*"There is a computer disease that anybody who works with computers knows about.
It's a very serious disease and it interferes completely with the work. The
trouble with computers is that you 'play' with them."* -- Richard Feynman

## Questions? Found a bug? Got an improvement?
Please create an [issue](https://github.com/yochem/dotfiles/issues/new)!

## License
Licensed under the MIT license.
