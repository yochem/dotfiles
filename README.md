# `/Users/yochem`
My configs for syncing across devices, sharing and other stuff.

### Structure
```bash
.atom/		    # atom configs
.nano/		    # nano syntax highlighting
.terminals/	    # config for iTerm2, Hyper and Terminal.app
bin/		    # some scripts I sometimes use
install/	    # for installing this repo
.aliases	    # bash aliases
.bash_profile	    # bundles .aliases, .exports, .functions, .prompt
.exports	    # $PATH and others
.functions	    # bash functions
.gitconfig	    # git configuration
.nanorc		    # nano rc file
.plrc		    # prolog rc file
.prompt		    # bash prompt
.screenrc	    # screen rc file stolen from @geohot
.vimrc		    # vim rc file
```

### Usage
If you just want to install the dotfiles:
```bash
$ curl -Lks https://raw.githubusercontent.com/yochem/dotfiles/master/install/dotinstall | /bin/bash
```
If you want to fully install devtools on a new system:
```bash
$ curl -Lks https://raw.githubusercontent.com/yochem/dotfiles/master/install/install | /bin/bash
```

### Thanks
A big shout out to [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
and [Lars Kappert](https://github.com/webpro/dotfiles) for their amazing work!
Also, thank you Nicola Paolucci for [this amazing article](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

### License
Licensed under the [MIT license](https://github.com/yochem/dotfiles/blob/master/LICENSE).
