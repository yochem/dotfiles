# `/Users/yochem && /home/yochem`
My configs for MacOS (and trying to keep it compatible for Linux). Also
includes the most user-frienldy MacOS `defaults` installationscript ever.

### Screenshots
![img](https://user-images.githubusercontent.com/23235841/53305538-e5928700-3882-11e9-8842-4d1245a82ce3.jpg)

### Installation
If you just want to install the dotfiles:
```bash
$ curl -Lks https://raw.githubusercontent.com/yochem/dotfiles/master/.install/dotinstall | /bin/bash
```
and installing Brew packages, Pip packages, Changing MacOS `defaults`,
new Bash, change the Dock and even more:
```bash
$ bash ~/.install/install
```
Which looks something like:

![installation script](https://media.giphy.com/media/3pAPsTr66NdEe8cgGa/giphy.gif)

Where the users press 'y' to accept or any other key to skip (no key pressed
at creating the the dock).

### What's inside?
I try to comply to the [XDG
standard](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
as much as possible.
- **Bash**: autocompletion, some aliases, a nice looking prompt with git
    branch and improved inputrc.
- **Vim**: Like really, quite a lot.
- **Other editors**: some modifications for Atom and Nano.
- **Git**: Just some small aliases, nothing too special.
- Configs for some other apps in `.config/`.
- Some script in `.local/bin/`, like cloning all users repos, `howto` for when
    you forget stuff, `gititall` to perform an action on all your repos, an
    update script, switching dark mode on MacOS, etc.

### Thanks!
A big shout out to [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
and [Lars Kappert](https://github.com/webpro/dotfiles) for their amazing work!
Also, thank you Nicola Paolucci for [this awesome article](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)
about the best way to version control your dotfiles.

### License
Licensed under the [MIT license](https://github.com/yochem/dotfiles/blob/master/LICENSE),
but do whatever you like with it.
