#!/usr/bin/env bash

# sourcing z
[ -f "$HOME/z.sh" ] && . "$HOME/z.sh"

# Load the shell dotfiles, and then some:
for file in ~/.{aliases,exports,functions,prompt}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# cd without typing cd
shopt -s autocd

# don't put duplicates in history
HISTCONTROL=ignoreboth

# only do this in an interactive shell
if [[ $- == *i* ]]; then
    # Show extra file information when completing, like `ls -F` does
    set visible-stats on

    # Perform file completion in a case insensitive fashion
    bind "set completion-ignore-case on"

    # show ambiguous files after just 1 tab press
    bind "set show-all-if-ambiguous on"

    # Enable history expansion with space
    bind Space:magic-space
fi

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion 2>/dev/null
[ -d /usr/local/etc/bash_completion.d ] && . /usr/local/etc/bash_completion.d/* 2>/dev/null
