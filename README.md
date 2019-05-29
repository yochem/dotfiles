# `/Users/yochem`
My configs for MacOS (and trying to keep it compatible for Linux). Also
includes the most user-frienldy MacOS `defaults` installation script ever.

### Screenshots
![img](https://user-images.githubusercontent.com/23235841/53305538-e5928700-3882-11e9-8842-4d1245a82ce3.jpg)

### Installation
If you just want to install the dotfiles:
```bash
$ curl -Lks https://raw.githubusercontent.com/yochem/dotfiles/master/.local/bin/dotinstall | $(which bash)
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

When installing on a Mac, don't forget these steps, too:
#### Three finger drag
`System Preferences > Accessibility > Mouse & Trackpad > Trackpad options > Enable dragging`

#### Remap capslock key to escape
`System Preferences > Keyboard > Modifier Keys... > Caps Lock Key`

#### Add other accounts to mac
`System Preferences > Internet Accounts`

#### Prefer opening in tabs instead of new window
`System Preferences > Dock > Prefer tabs when opening documents > Always`

- Sidebar Finder
- set up ssh connections

### What's inside?
I try to comply to the [XDG
standard](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
as much as possible. Because of this, most configuration can be found in
`.config/`. This repo also contains my bin (`.local/bin/`), which contains some
small scripts like cloning all users repos, `howto` for when you forget stuff,
`gititall` to perform an action on all your repos, an update script, switching
dark mode on MacOS, etc.

### Thanks!
A big shout out to [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
and [Lars Kappert](https://github.com/webpro/dotfiles) for their amazing work!
Also, thank you Nicola Paolucci for [this awesome
article](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)
about the best way to version control your dotfiles.

### License
Licensed under the [MIT
license](https://github.com/yochem/dotfiles/blob/master/LICENSE), but do
whatever you like with it.

> There is a computer disease that anybody who works with computers knows
> about. It's a very serious disease and it interferes completely with the
> work. The trouble with computers is that you 'play' with them.

-- Richard Feynman
