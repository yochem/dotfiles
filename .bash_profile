#!/usr/bin/env bash

# Load the shell dotfiles, and then some:
for file in ~/.{aliases,exports,functions,prompt}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# don't put duplicates in history
HISTCONTROL=ignoreboth
# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# cd without typing cd
shopt -s autocd

# vi key bindings in bash
set -o vi

# Add tab completion for many Bash commands
if command -V brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
    source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
fi

# sourcing z
[ -f "$HOME/z.sh" ] && . "$HOME/z.sh"
