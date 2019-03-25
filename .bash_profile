#!/usr/bin/env bash

# first checking if iTerm. This fixes the issue of not recognising
# $SSH_CLIENT without resourcing .bash_profile
test -e "$HOME/.iterm2_shell_integration.bash" && source "$HOME/.iterm2_shell_integration.bash"

# Load the shell dotfiles, and z.sh
for file in ~/.{prompt,exports,aliases,functions,z.sh}; do
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
if [[ "$-" == *i* ]]; then
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

# don't let Terminal.app write session history
# (https://stackoverflow.com/questions/32418438/how-can-i-disable-bash-sessions-in-os-x-el-capitan)
SHELL_SESSION_HISTORY=0

