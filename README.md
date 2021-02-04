# `/Users/yochem`
My configs for MacOS and Linux (tested on Ubuntu). Also
includes the most user-frienldy MacOS [installation
script](.local/bin/macdefaults) ever.

### Screenshots
![img](https://user-images.githubusercontent.com/23235841/63441128-38638a80-c431-11e9-8e42-32f6965589aa.png)

I try to comply to the [XDG
standard](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
as much as possible. **My `$HOME` directory is litter free!**

XDG               | Linux & MacOS
------------------|-----------------
`XDG_CONFIG_HOME` | `~/.config`
`XDG_DATA_HOME`   | `~/.local/share`
`XDG_CACHE_HOME`  | `~/.cache`
bin               | `~/.local/bin`

### Installation
If you just want to install the dotfiles:
```bash
$ curl -Lks https://raw.githubusercontent.com/yochem/dotfiles/main/.local/bin/dotinstall | $(which bash)
```
This script will check if there are any existing files and move them to
`$HOME/dotfiles-backup/`. It uses a Git bare repository to manage the
dotfiles.

If you want to install Brew packages, Pip packages, change some MacOS
`defaults`, update Bash, change the Dock and even more:
```bash
$ $HOME/.local/bin/install
```
Which looks something like:

![installation script](https://media.giphy.com/media/3pAPsTr66NdEe8cgGa/giphy.gif)

Where the users press 'y' to accept or any other key to skip (no key pressed
at creating the the dock).

### Why?
*"There is a computer disease that anybody who works with computers knows about.
It's a very serious disease and it interferes completely with the work. The
trouble with computers is that you 'play' with them."* -- Richard Feynman

### Thanks!
A big shout out to [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
and [Lars Kappert](https://github.com/webpro/dotfiles) for their amazing work!
Also, thank you Nicola Paolucci for [this awesome
article](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)
about the best way to version control your dotfiles.

### Questions? Found a bug? Got an improvement?
Please create an [issue](https://github.com/yochem/dotfiles/issues/new)!

### License
Licensed under the MIT license.
