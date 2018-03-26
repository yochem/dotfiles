# dotfiles

```bash
$ ~/.*
```
You know I had to do it like all the cool kids :sunglasses:.

**Warning** Be careful when using the commands used in e.g. `install/.macdefaults`. Only use these
commands if you know what the effects will be.

### Structure
```
atom/                 # Atom's config, keymap and styles files
bash/                 # Aliases, functions and the prompt I use (and more)
git/                  # gitconfig: useful aliases and other settings
install/              # .macdefaults and other things to install on a new mac with the install script
.hyper.js             # the Hyper config file
dot                   # script to use this project: dot install, dot update...
update                # Update Brew & Cask, Ruby & gems, NPM, Pip, Atom (packages) and App Store
```


Feel free to ask questions, drop a suggestion or open an issue!

### Usage
download or clone this repository to wherever you want. Then run
```bash
$ cd path/to/dotfiles
```
To run dot:
```bash
$ bash dot <args>
```
If you need a little help:
```bash
$ bash dot --help
```

### Thanks
A big shout out to [Mathias Bynens](https://github.com/mathiasbynens/dotfiles) and [Lars Kappert](https://github.com/webpro/dotfiles) for their amazing work!

### License
Licensed under the [MIT license](https://github.com/yochem/dotfiles/blob/master/LICENSE).
