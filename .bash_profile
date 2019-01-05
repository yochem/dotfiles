#!/usr/bin/env bash

# Load the shell dotfiles, and then some:
for file in ~/.{aliases,exports,functions,prompt}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# show ambiguous files after just 1 tab press
bind "set show-all-if-ambiguous on"

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# don't put duplicates in history
HISTCONTROL=ignoreboth
# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# cd without typing cd
shopt -s autocd

# Enable history expansion with space
bind Space:magic-space

# Add tab completion for many Bash commands
if command -V brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
    source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
fi

# sourcing z
[ -f "$HOME/z.sh" ] && . "$HOME/z.sh"
