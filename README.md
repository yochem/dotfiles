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
are managed using a Makefile. This makes the configuration modular and allows
me to install only the configuration from the programs I need at that moment.
All commands overwrite the current configuration. Here are the Make commands:

- `make all`: link all files from this repo to their respective (`XDG_*`
  locations).
- `make [config|data|home|bin]`: Only install content from these directories.
- `make <program>`: Install config for that program, independent of which
  directory it is in (multiple also possible).
- `make mac`: MacOS specific stuff.
- `make clean-[config|data|home|bin]`: Remove only the programs that are synced
  with this repo from their target directories
- `make clean`: Remove only the programs that are synced with this repo from
  all target directories.

## Why?
*"There is a computer disease that anybody who works with computers knows about.
It's a very serious disease and it interferes completely with the work. The
trouble with computers is that you 'play' with them."* -- Richard Feynman

## Questions? Found a bug? Got an improvement?
Please create an [issue](https://github.com/yochem/dotfiles/issues/new)!

## License
Licensed under the MIT license.
